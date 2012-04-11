require 'spec_helper'

describe Wordy::Job do
  
  let(:wordy_job) do 
      {
        "status"                => "acp",
        "source_language_name"  => "English (UK)",
        "source_word_count"     => 2,
        "cost"                  => "$9.00",
        "intrusive_editing"     => false,
        "target_url"            => "/jobs/17792/target/",
        "created"               => 1334065282,
        "brief"                 => "Great editing!",
        "delivery_date"         => 1334065882,
        "source_url"            => "/jobs/17792/source/"
      }
    end
  
  describe "Getting the list of all the jobs" do
    it "should gather a list of job ids" do
      Wordy::Cli.stub!(:http_get).and_return([33, 666])
      Wordy::Job.all.map(&:id).should == [33, 666]
    end
  end
  
  describe "Creating a new job" do
    # What params to provide?
  end
  
  describe "Accessing a specific job" do
    it "should gather a list of job ids" do
      Wordy::Cli.stub!(:http_get).and_return(wordy_job)
      job = Wordy::Job.find(666)
      job.delivery_date.should == DateTime.parse('2012-04-10T15:51:22+02:00')
      job.id.should == 666
    end
  end
  
  describe "Fetching info on a job" do
    it "should update the attributes of a job based on info from Wordy" do
      @job = Wordy::Job.new({'id' => 666})
      Wordy::Cli.stub!(:http_get).and_return(wordy_job)
      @job.info
      @job.delivery_date.should == DateTime.parse('2012-04-10T15:51:22+02:00')
      @job.id.should == 666
    end
  end
  
  describe "Paying for a job" do
  end
  
  describe "Rejecting a job" do
  end
  
  describe "Confirming a job" do
  end
end