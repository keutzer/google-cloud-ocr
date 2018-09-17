import argparse
import os
import re
import math

from pdf2image import convert_from_path
from google.cloud import storage

parser = argparse.ArgumentParser()
parser.add_argument("--filepath", type=str, help="Path to local image file", required=True)
parser.add_argument("--output-dir", type=str, help="Path to local output dir (defaults to original file path)")


def convert_to_jpg(args):
    print("Converting file {} to jpg".format(args.filepath))
    path_book_name = os.path.splitext(args.filepath)[0]
    book_name = os.path.split(path_book_name)[-1]
    pages = convert_from_path(args.filepath, 500)

    n = int(math.ceil(math.log(len(pages)) / math.log(10)))

    for i, page in enumerate(pages):
        number_str = "_{num:0{width}}.jpg".format(num=i+1, width=n)
        if args.output_dir:
            output_name = os.path.join(args.output_dir, book_name + number_str)
        else:
            output_name = path_book_name + number_str
        page.save(output_name, 'JPEG')


if __name__ == "__main__":
    args = parser.parse_args()
    convert_to_jpg(args)