require 'puppet'
Puppet::Reports.register_report(:report_status) do
  desc "document the report"
  def process
    File.open('/var/lib/puppet/reports/report.txt', 'a') do |f|
      resource_statuses.each do |resource_name, resource|
        # resource_name is a String
        # resource      is a Puppet::Resource::Status
        resource.events.each do |e|
          f.puts "#{resource_name}[#{e.property}]: Changing #{e.previous_value} => #{e.desired_value}"
        end
      end
    end
  end
end
