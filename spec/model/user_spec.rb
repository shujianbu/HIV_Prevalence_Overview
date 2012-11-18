require 'spec_helper'

describe User do
	[:username, :password].each do |field|
		it { should validate_presence_of(field) }
	end
	it { should validate_uniqueness_of(:username) }
end