require 'rails_helper'

RSpec.describe Member, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  # before(:each) do
  #   puts "executed before...."
  #   @member = Member.create
  # end

  describe "let" do
    let!(:member){Member.create}

  end


  it "POST/test" do
    post "/test", member:{ name: "ttt"}
    expect(response).to redirect_to('/test')
    #expect(response.status).to eq(404)

  end
  #byebug
  #response.body
  #response.public_methods(false)
  #加false 可以找出自己的class底下的方法

  expect{
    post "/test",params:{ member:{ name: "tt"}}
  }.to change{Member.count}.by(1)

  it "+" do
    puts "1"
    expect(@member.update(name: "QQ")).to eq(true)
  end
  it "*" do
    puts "2"
    expect(@member.update(name: "QQ")).to eq(true)
  end
  it "-" do
    puts "3"
    expect(@member.update(name: "QQ")).to eq(true)
  end

  describe "when " do
    it "change" do
      puts "4"
      expect(Member.count).to eq(0)
      Member.create
      expect(Member.count).to eq(1)
      #++++++++++++++++
      expect{
        Member.create
      }.to change{Member.count}.by(1)
      #-----------
      # expect{do something}.to change{......}by(2)

    end

  end



end
