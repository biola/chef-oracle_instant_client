#!/usr/bin/env bats

@test "oracle instant client library found in ld_library_path" {
  grep instantclient_ /etc/profile.d/oracle_instant_client.sh
}
