import argparse
import os

from google.cloud import storage
from google.cloud import vision
from google.protobuf import json_format


parser = argparse.ArgumentParser()
parser.add_argument("--filepath", type=str, help="(google storage) Path to input file", required=True)
parser.add_argument("--output-dir", type=str, help="(local) Path to output dir")
parser.add_argument("--bucket", type=str, help="Google storage bucket name", required=True)

def detect_document_tibetan(args):
    """Detects text in the file located in Google Cloud Storage or on the Web.
    """
    book_name = os.path.splitext(args.filepath)[0]
    gcs_uri = "gs://" + args.bucket + "/" + args.filepath
    print("Running document text detection on: {}".format(gcs_uri))
    client = vision.ImageAnnotatorClient()
    image = vision.types.Image()
    image_context = vision.types.ImageContext(language_hints=["bo"])
    image.source.image_uri = gcs_uri

    response = client.document_text_detection(image=image, image_context=image_context)
    text = response.full_text_annotation.text

    print(u'Output:\n{}'.format(text))

    output_name = os.path.join(args.output_dir, +".txt") if args.output_dir else book_name+".txt"
    with open(output_name, "w") as f:
        f.write(text)
        

if __name__ == "__main__":
    args = parser.parse_args()
    detect_document_tibetan(args)
