# Data from https://drive.google.com/drive/u/3/folders/14x2_3ZS-XguLldWWZW5uGBYViX8kJIPw

# Install necessary requirements
pip -q -q install -r requirements.txt --upgrade

# We need to install poppler for converting pdfs to images
conda install -c conda-forge poppler

# Make sure to use your own bucket, you will not have access to this one
cloud_bucket_name="ocr-tutorial-20220901"

for local_path in data/*.pdf
do
    python pdf_to_jpg_dir.py --filepath "$local_path" --bucket $cloud_bucket_name
    python transcribe_image_dir.py --filepath "${local_path#*/}" --bucket $cloud_bucket_name --output-dir results
done
