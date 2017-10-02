#!/opt/puppetlabs/puppet/bin/ruby

require 'json'

dividend = ENV['PT_dividend']
divisor = ENV['PT_divisor']

result = {}
begin
  result['result'] = dividend.to_i / divisor.to_i

rescue ZeroDivisionError
  result[:_error] = { msg: "Cannot divide by zero",
                      # We namespace the error to our module
                      kind: "puppetlabs-example_modules/dividebyzero",
                      details: { divisor: divisor },
                    }
rescue Exception => e
  result[:error] = { msg: e.message,
                     kind: "puppetlabs-example_modules/unknown",
                     details: { class: e.class.to_s },
                   }
end

puts result.to_json
