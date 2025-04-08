#!/bin/bash
# Update and install Apache2
apt update
apt install -y apache2

# Start and enable Apache2
systemctl start apache2
systemctl enable apache2

# Copy this script to index.html to serve it at http://<internal-ip>/
cp $0 /var/www/html/index.html
chmod 644 /var/www/html/index.html

# GCP Metadata server base URL and header
METADATA_URL="http://metadata.google.internal/computeMetadata/v1"
METADATA_FLAVOR_HEADER="Metadata-Flavor: Google"

# Use curl to fetch instance metadata
local_ipv4=$(curl -H "${METADATA_FLAVOR_HEADER}" -s "${METADATA_URL}/instance/network-interfaces/0/ip")
zone=$(curl -H "${METADATA_FLAVOR_HEADER}" -s "${METADATA_URL}/instance/zone")
project_id=$(curl -H "${METADATA_FLAVOR_HEADER}" -s "${METADATA_URL}/project/project-id")
network_tags=$(curl -H "${METADATA_FLAVOR_HEADER}" -s "${METADATA_URL}/instance/tags")

# Create a simple HTML page
cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
  <title>Japan - Be A Man Level 3 </title>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
  <style>
    body,h1,h3 {font-family: "Raleway", sans-serif}
    body, html {height: 100%}
    .bgimg {
      background-image: url('https://japan-2025.s3.us-east-1.amazonaws.com/japan-bg.jpg');
      min-height: 100%;
      background-position: center;
      background-size: cover;
    }
    .w3-display-middle {
      background-color: rgba(0, 0, 0, 0.466);
      padding: 20px;
      border-radius: 10px;
    }
    .transparent-background {
      background-color: rgba(0, 0, 0, 0.575);
      padding: 20px;
      border-radius: 10px;
    }
  </style>
</head>
<body>
  <div class="bgimg w3-display-container w3-animate-opacity w3-text-white">
    <div class="w3-display-topleft w3-padding-large w3-xlarge"></div>
    <div class="w3-display-middle w3-center">
      <iframe src="https://japan-2025.s3.us-east-1.amazonaws.com/japan4.gif"
              width="220"
              height="391"
              style="border-radius:10px;"
              frameBorder="0"
              class="giphy-embed"
              allowFullScreen>
      </iframe>
      <hr class="w3-border-grey" style="margin:auto;width:40%;margin-top:15px;">
      <h3 class="w3-large w3-center" style="margin-top:15px;">
        <a href="https://github.com/tiqsclass6/gcp-ha-multi-region-webserver"
           class="w3-button w3-transparent w3-border w3-border-white w3-round-large w3-text-white"
           style="margin-bottom:0px;"
           target="_blank">
          Source Code
        </a>
      </h3>
    </div>
    <div class="w3-display-bottomleft w3-padding-small transparent-background">
      <h1>Be a Man Level 4 - Japan WebServer</h1>
      <h3><b>I, TIQS, thank you, Sensei Theo and Lord Beron!</h3>
      <h3>Team Group Leader - John Sweeney</h3>
      <p><b>Instance Name:</b> $(hostname -f)</p>
      <p><b>Instance Private IP Address: </b> $local_ipv4</p>
      <p><b>Zone: </b> $zone</p>
      <p><b>Project ID:</b> $project_id</p>
      <p><b>Network Tags:</b> $network_tags</p>
    </div>
  </div>
</body>
</html>
EOF