# Part 1: Setting Up Google Cloud

## Step 1: Create a Google Cloud account
If you haven't created a Google Cloud account before, register for a new account with $300 of credits for 1 year [here](https://console.cloud.google.com/freetrial). 

## Step 2: Provision Google Cloud resources
Create a new Google Cloud project from the [cloud resource manager](https://console.cloud.google.com/cloud-resource-manager). More information [here](https://cloud.google.com/resource-manager/docs/creating-managing-projects).

Create a new Google Cloud bucket from the [storage browser](https://console.cloud.google.com/storage/browser). Make sure the project you just created is selected as in the image below:

![Storage bucket creation interface][image1]

Remember the name of your bucket, this will be important later.

## Step 3: Set up authentication protocol
A service account is distinguished from the Google Cloud account you created to get free credits. Create a new service account for your newly created Google Cloud project [here](https://console.cloud.google.com/iam-admin/serviceaccounts) by clicking the "+ CREATE SERVICE ACCOUNT" button.

![Service account creation button][image2]

Name your account, add the "Storage - Storage Admin" role and select the "Furnish a new private key" with a JSON key type. Click "Save" and your key should download. Avoid sharing this key as it provides administrative privileges to your storage buckets on Google Cloud!

![Service account creation details screen][image3]

More information on creating a service account found [here](https://cloud.google.com/iam/docs/creating-managing-service-accounts#creating_a_service_account).

Now set the `GOOGLE_APPLICATION_CREDENTIALS` environment variable in your terminal to authenticate using Application Default Credentials.

From Google's documentation:

>If you're using a client library to call the Vision API, use Application Default Credentials (ADC). Services using ADC look for credentials within a `GOOGLE_APPLICATION_CREDENTIALS` environment variable. Unless you specifically wish to have ADC use other credentials (for example, user credentials), we recommend you set this environment variable to point to your service account key file.

`export GOOGLE_APPLICATION_CREDENTIALS=PATH_TO_KEY_FILE`

>Replace `PATH_TO_KEY_FILE` with the path to your JSON service account file. `GOOGLE_APPLICATION_CREDENTIALS` should be written out as-is (it's not a placeholder in the example above).

If you don't know what the path to your key file is and you are using a Mac, `~/Downloads/FILENAME` where `FILENAME` is the full name of the file that downloaded automatically after you created the service account.


# Part 2: Download libraries and the OCR script

## Step 1: Install the Google Cloud Python library 
Install the Python API library for Google Cloud Vision with the following command in your terminal:

    pip3 install --upgrade google-cloud-vision

Then install the Google Cloud Storage library with:

    pip3 install --upgrade google-cloud-storage

## Step 2: Download the `transcribe.py` script in this repository
You can either right click the link to `transcribe.py` and hit "Save As" or download the entire repository as a .zip from the "Clone or download" button shown in the image below.

![Download options on Github][image4]

# Part 3: Upload OCR target files and launch script

## Step 1: Upload desired files to your Google Storage bucket
Upload a .pdf or .tiff file you wish to transcribe using the web client found [here](https://console.cloud.google.com/storage/browser)

![File upload interface][image5]

## Step 2: Launch script
Navigate to the directory containing the `transcribe.py` script downloaded earlier and launch script with:

    python transcribe.py --filepath CLOUD_PATH --bucket BUCKET_NAME>

Where `CLOUD_PATH` is a placeholder and should be replaced with the path to your file within the Google Storage bucket (just the full filename e.g. "book.pdf" if uploaded in the previous step without creating any intermediate directories in the bucket). 

And `BUCKET_NAME` is a placeholder and should be replaced with the full name of the storage bucket (without the "gs://" prefix).

If your target file is a .tiff instead of a .pdf, simply add the tiff flag like so:

    python transcribe.py --filepath CLOUD_PATH --bucket BUCKET_NAME> --tiff


[image1]: (image1.png)
[image2]: (image2.png)
[image3]: (image3.png)
[image4]: (image4.png)
[image5]: (image5.png)