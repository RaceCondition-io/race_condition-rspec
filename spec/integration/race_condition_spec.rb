require "spec_helper"

describe "RaceCondition" do
  it "works" do
    out = run_command "rspec spec/fakes/simple.rb"
    expect(out["examples"].first["type"]).to eq "feature"
  end

  def run_command(command)
    out = `#{command}`
    out = out.split("failures\n")
    JSON.parse(out[1])
  end
end
