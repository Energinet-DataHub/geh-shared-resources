# Copyright 2020 Energinet DataHub A/S
#
# Licensed under the Apache License, Version 2.0 (the "License2");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

###################################################################
#
# Install GitHub runner and other software dependencies
# necessary for running our deployments
#
###################################################################

##################################
# GitHub runner
##################################

#
# Download
#

# Create a folder
mkdir actions-runner && cd actions-runner

# Download the latest runner package
curl -o actions-runner-linux-x64-2.285.1.tar.gz -L https://github.com/actions/runner/releases/download/v2.285.1/actions-runner-linux-x64-2.285.1.tar.gz

# Validate the hash
echo '5fd98e1009ed13783d17cc73f13ea9a55f21b45ced915ed610d00668b165d3b2  actions-runner-linux-x64-2.285.1.tar.gz' | shasum -a 256 -c

# Extract the installer
tar xzf ./actions-runner-linux-x64-2.285.1.tar.gz

#
# Configure
#

# Create the runner and start the configuration experience
./config.sh --unattended --url https://github.com/Energinet-DataHub/dh3-environments --token $1 --labels azure --replace

#
# Run as a service
#

sudo ./svc.sh install
sudo ./svc.sh start
sudo ./svc.sh status

##################################
# Install other dependencies
##################################

# Install unzip
sudo apt-get install unzip
