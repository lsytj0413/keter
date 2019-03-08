# Copyright (c) 2018 soren yang
#
# Licensed under the MIT License
# you may not use this file except in complicance with the License.
# You may obtain a copy of the License at
#
#     https://opensource.org/licenses/MIT
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Track code version with Docker Label.
DOCKER_LABELS ?= git-describe="$(shell date -u +v%Y%m%d)-$(shell git describe --tags --always --dirty)"

# Current version of the project.
VERSION ?= $(shell git describe --tags --always --dirty)

# It's necessary to set this because some environments don't link sh -> bash.
export SHELL := /bin/bash

# It's necessary to set the errexit flags for the bash shell.
export SHELLOPTS := errexit

# Project output directory
OUTPUT_DIR := ./bin

.PHONY: clean

all: clean

build-image:
	docker build -t keter:$(VERSION) -f build/Dockerfile.ansible .

clean:
	-rm -vrf ${OUTPUT_DIR}
