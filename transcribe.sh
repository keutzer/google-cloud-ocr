# Data from https://drive.google.com/drive/u/3/folders/14x2_3ZS-XguLldWWZW5uGBYViX8kJIPw

# Make sure to use your own bucket, you will not have access to this one
bucket_name="ocr-tutorial-20220901"


cloud_paths=(
    "1-Jinpa-Thupten_2004_Theg-pa-chen-po-blo-sbyong-brgya-rtsa_LOTC-1 (1).pdf"
    "2-Jinpa_2005_Bka-gdams-glegs-bam-las-btus-pa_i-chos-skor_LOTC-2.pdf"
    "3-Jinpa_2005_rdzogs-pa-chen-po-sems-nyid-ngal-gso_i-_grel-pa-shing-rta-chen-po_LOTC-3.pdf"
    "4-Jinpa_2004_dpal-sakya-pa_i-lam-_bras-kyi-chos-skor-gces-btus_LOTC-4.pdf"
    "5-Jinpa_2008_mnyam-med-bka_-brgyud-lugs-kyi-phyag-rgya-chen-po-dang-_brel-ba_i-chos-skor_LOTC-5.pdf"
    "6-Jinpa_2005_dpal-dge-ldan-pa_i-lam-rim-dang-snyan-brgyud-kyi-chos-skor_LOTC-6.pdf"
    "7-Jinpa-JO-NANG-CHOS-SKOR-RI-CHOS-NGES-DON-RGYA-MTSO-LoTC-VOL-7.pdf"
    "8-Jinpa-ZHI-BYED-DANG-GCOD-YUL-SOGS-GDAMS-NGAG-THOR-BU_I-CHOS-SKOR-LoTC.pdf"
    "9-Jinpa-gyung-drung-bon-gyi-mdo-sngags-sems-gsum-gyi-gzhung.pdf"
    "10-Jinpa-bstan-pa-la-_jug-pa_i-rim-pa-son-pa_i-gzhung-gces-btus.pdf"
    "11-Jinpa-RGYAL-SRAS-KYI-SPYOD-PA-LA-_JUG-PA_I-CHOS-SKOR.pdf"
    "13-Jinpa-RNAL-_BYOR-BLA-MED-KYI-SGRUB-THABS-DANG-BSKYED-RIM-GYI-KHRID-YIG-KHAG-LoTC-VOL-13.pdf"
    "14-Jinpa-DUS-_KHOR-_GREL-CHEN-DRI-MED-_OD-KYI-RGYAN-LoTC-VOL-14.pdf"
    "15-Jinpa-RDZOGS-RIM-RIM-LNGA-GSAL-SGRON-LoTC-VOL-15-Scan.pdf"
    "17-Jinpa-2007_bde-gshegs-snying-po-rigs-kyi-chos-skor_Institute-for-Tibetan-Classics.pdf"
    "19-Jinpa-DBU-MA-DGONGS-PA-RAB-GSAL-LoTC-VOL-19-Scan.pdf"
    "20-Jinpa-DPAL-SA-SKYA-PA_I-TSAD-MA-RIG-PA_I-GZHUNG-GCES-BTUS-LoTC-VOL-20-Scan.pdf"
    "21-Jinpa-DPAL-DGE-LDAN-PA_I-TSAD-MA-RIG-PA_I-GZHUNG-GCES-BTUS-LoTC-VOL-21-Scan.pdf"
    "23-Jinpa-CHOS-MNGON-PA-MDZOD-KYI-_GREL-PA-MNGON-PA_I-RGYAN-LoTC-VOL-23-Scan.pdf"
    "24-Jinpa-GRUB-MTHA-THUB-BSTAN-LHUN-PO_I-MDZES-RGYAN-LoTC-VOL-24-Scan.pdf"
    "25-Jinpa-GRUB-MTHA-SHEL-GYI-ME-LONG-LoTC-VOL-25-Scan.pdf"
    "27-Jinpa-LEGS-BSHAD-LUGS-KYI-BSLAB-BYA_I-DPE-TSOGS-LoTC-VOL-27-Scan.pdf"
    "28-Jingpa-BDE-GSHEGS-SNYING-PO-RIGS-KYI-CHOS-SKOR-LoTC-VOL-28-Scan.pdf"
    "29-Jinpa-RTSIS-KYI-MAN-NGAG-NYIN-BYED-SNANG-BA_I-RANAM-_GREL-GSER-GYI-SHING-RTA-LoTC-VOL-29-Scan.pdf"
    "31-Jingpa-BOD-KYI-LHA-MO_I-KHRAB-GZHUNG-CHE-KHAG-GCES-BTUS-LoTC-VOL-31-Scan.pdf"
    "32-Jinpa-MKHAS-PA-LDE_US-MDZAD-PA_I-RGYA-BOD-KYI-CHOS-_BYUNG-RGYAS-PA-LoTC-VOL-32-Scan.pdf"
)

for cloud_path in ${cloud_paths[*]}
do
    python transcribe_bo-fo.py --output-dir results --filepath "$cloud_path" --bucket "$bucket_name"
done
