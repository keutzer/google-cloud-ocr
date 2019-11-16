import argparse
import os
import re

from google.cloud import storage
from google.cloud import vision
from google.protobuf import json_format


parser = argparse.ArgumentParser()
parser.add_argument("--filepath", type=str, help="(google storage) Path to input file", required=True)
parser.add_argument("--output-dir", type=str, help="(local) Path to output dir")
parser.add_argument("--tiff", action="store_true", help="Transcribe .tiff instead of .pdf file")
parser.add_argument("--bucket", type=str, help="Google storage bucket name", required=True)


def async_detect_document_tibetan(args):
    book_name = os.path.splitext(args.filepath)[0]
    gcs_source_uri = "gs://" + args.bucket + "/" + args.filepath
    gcs_destination_uri = "gs://" + args.bucket + "/" + book_name + "/"

    """OCR with PDF/TIFF as source files on GCS"""
    # Supported mime_types are: 'application/pdf' and 'image/tiff'
    mime_type = 'image/tiff' if args.tiff else 'application/pdf'

    # How many pages should be grouped into each json output file.
    batch_size = 1

    client = vision.ImageAnnotatorClient()

    feature = vision.types.Feature(
        type=vision.enums.Feature.Type.DOCUMENT_TEXT_DETECTION)

    gcs_source = vision.types.GcsSource(uri=gcs_source_uri)
    input_config = vision.types.InputConfig(
        gcs_source=gcs_source, mime_type=mime_type)

    gcs_destination = vision.types.GcsDestination(uri=gcs_destination_uri)
    output_config = vision.types.OutputConfig(
        gcs_destination=gcs_destination, batch_size=batch_size)

    image_context = vision.types.ImageContext(language_hints=["sa"])

    async_request = vision.types.AsyncAnnotateFileRequest(
        features=[feature], input_config=input_config,
        output_config=output_config, image_context=image_context)

    operation = client.async_batch_annotate_files(
        requests=[async_request])

    print('Waiting for the operation to finish.')
    operation.result()

    # Once the request has completed and the output has been
    # written to GCS, we can list all the output files.
    storage_client = storage.Client()
    bucket = storage_client.get_bucket(bucket_name=args.bucket)

    # List objects with the given prefix.
    get_file_number = lambda name: int(re.search(r'(\d+)\.json', name).group(1))
    blob_list = sorted([(get_file_number(blob.name), blob) for blob in bucket.list_blobs(prefix=book_name+"/")])
    print('Output files:')
    for _, blob in blob_list:
        print(blob.name)

    output_name = os.path.join(args.output_dir, book_name+".txt") if args.output_dir else book_name+".txt"

    print('Collecting all text locally as {}'.format(output_name))

    with open(output_name, "w") as f:
        # Collect all text from outputs 
        for i, output in blob_list:
            json_string = output.download_as_string()
            response = json_format.Parse(
                json_string, vision.types.AnnotateFileResponse())

            # The actual response for the first page of the input file.
            first_page_response = response.responses[0]
            annotation = first_page_response.full_text_annotation

            f.write(annotation.text)

            if i == 1:
                # Here we print the full text from the first page.
                # The response contains more information:
                # annotation/pages/blocks/paragraphs/words/symbols
                # including confidence scores and bounding boxes
                print(u'Full text:\n{}'.format(
                    annotation.text))

if __name__ == "__main__":
    args = parser.parse_args()
    async_detect_document_tibetan(args)
