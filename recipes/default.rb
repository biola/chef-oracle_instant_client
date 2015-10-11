class Chef::Recipe
  include OracleInstantClientHelpers
end

class Chef::Resource
  include OracleInstantClientHelpers
end

package 'unzip'
package 'libaio-dev'

directory base_dir do
  action :create
end

node['oracle_instant_client']['files'].each do |name, url|
  unless url.nil?
    remote_file File.join(base_dir, "instantclient-#{name}.zip") do
      source url
      action :create_if_missing
    end
  end
end

unless lib_path
  bash 'unzip_files' do
    cwd base_dir
    code 'unzip -n ./instantclient-\*.zip'
  end
end

# This resource is a ruby_block because the standard Chef resources
# are evaluated before the run list has been excetude. Which means the
# .zip files haven't been unzipped and lib_path is nil.
# ruby_block resources, however, are run at execute time.
# Once we've upgraded to Chef 11.6 lazy attribute evaluation could probably
# be used instead.
# http://docs.opscode.com/release_notes.html#lazy-attribute-evaluation
ruby_block 'link_libclntsh.so' do
  block do
    unless File.exists? File.join(lib_path, 'libclntsh.so')
      Dir.chdir lib_path
      File.symlink libclntsh_file, 'libclntsh.so'
    end
  end
end

# Set environment variable
# Wrapped in a ruby_block so the lib_path is evaluated correctly on
# the first chef-client run
ruby_block 'oic_ldlibrary_setup' do
  block do

    r = Chef::Resource::Template.new('oracle_instant_client_profile', run_context)
    r.path       '/etc/profile.d/oracle_instant_client.sh'
    r.source     'oracle_instant_client.sh.erb'
    r.cookbook   'oracle_instant_client'
    r.variables  ({
      :lib_path => Dir[File.join(base_dir, 'instantclient*')].find { |f| File.directory?(f) }
    })
    r.run_action :create

  end
end
