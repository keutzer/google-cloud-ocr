## Step 1: Create service account and set authentication
Create a new service account for your Google Cloud project [here](https://console.cloud.google.com/projectselector/iam-admin/serviceaccounts) and select JSON as your key type. Then add the "Storage - Storage Admin" role and download the service account key onto your local machine.

More information on creating a service account found [here](https://cloud.google.com/iam/docs/creating-managing-service-accounts#creating_a_service_account).

Then follow instructions to set the `GOOGLE_APPLICATION_CREDENTIALS` environment variable to authenticate using Application Default Credentials.

From Google's documentation:

>If you're using a client library to call the Vision API, use Application Default Credentials (ADC). Services using ADC look for credentials within a `GOOGLE_APPLICATION_CREDENTIALS` environment variable. Unless you specifically wish to have ADC use other credentials (for example, user credentials), we recommend you set this environment variable to point to your service account key file.

`export GOOGLE_APPLICATION_CREDENTIALS=PATH_TO_KEY_FILE`

>Replace `PATH_TO_KEY_FILE` with the path to your JSON service account file. `GOOGLE_APPLICATION_CREDENTIALS` should be written out as-is (it's not a placeholder in the example above).

## Step 2: Upload desired file to gs bucket
Create a new Google Storage bucket if necessary then upload files to bucket either using `gsutil` or the web client found [here](https://console.cloud.google.com/storage/browser).

## Step 3: Install Google Cloud Python library
Install the Python API library for Google Cloud Vision with the following command: `pip install --upgrade google-cloud-vision`. Then install the Google Cloud Storage library with: `pip install --upgrade google-cloud-storage`.

## Step 4: Launch script
Launch script with `python transcribe.py --filepath <CLOUD PATH> --bucket <GS BUCKET NAME>`.