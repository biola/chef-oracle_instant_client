## oracle_instant_client Cookbook

Installs the [Oracle Instant Client.](http://www.oracle.com/technetwork/database/features/instant-client/index-097480.html)

## Usage

Download the installers to your local webserver, set the appropriate attributes (as noted below) for your node, and include the `oracle_instant_client` default recipe in your run_list:

```json
{
  "default_attributes": {
    "oracle_instant_client": {
      "files": {
        "sqlplus": "http://myserver.example.org/instantclient-sqlplus-linux.x64-ver.zip",
        "basiclite": "http://myserver.example.org/instantclient-basiclite-linux.x64-ver.zip",
        "sdk": "http://myserver.example.org/instantclient-sdk-linux.x64-ver.zip"
      }
    }
  },
  "run_list": [
    "recipe[oracle_instant_client::default]"
  ]
}
```

## License and Authors
 Copyright 2014, Biola University 

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.

