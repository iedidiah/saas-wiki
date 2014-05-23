require 'spec_helper'

describe Collaborator do
  describe "Validations" do

    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:wiki_id) }

    it {should validate_uniqueness_of(:user_id).scoped_to(:wiki_id) }
  end
end
