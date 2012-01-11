require 'spec_helper'

describe Virtus::Attribute::Time, '#coerce' do
  subject { attribute.coerce(value) }

  let(:attribute) { described_class.new(:bday) }

  let(:year)  { 1983 }
  let(:month) { 11 }
  let(:day)   { 18 }
  let(:hour)  { 8 }
  let(:min)   { 16 }
  let(:sec)   { 32 }

  shared_examples_for "a correct time" do
    it          { should be_kind_of(Time) }
    its(:year)  { should eql(year)  }
    its(:month) { should eql(month) }
    its(:day)   { should eql(day)   }
    its(:hour)  { should eql(hour)  }
    its(:min)   { should eql(min)   }
    its(:sec)   { should eql(sec)   }
  end

  context 'with a date' do
    let(:hour) { 0 }
    let(:min)  { 0 }
    let(:sec)  { 0 }

    it_should_behave_like "a correct time" do
      let(:value) { DateTime.new(year, month, day, hour, min, sec) }
    end
  end

  context 'with a date time' do
    it_should_behave_like "a correct time" do
      let(:value) { DateTime.new(year, month, day, hour, min, sec) }
    end
  end

  context 'with a hash' do
    it_should_behave_like "a correct time" do
      let(:value) do
        { :year => year, :month => month, :day => day,
          :hour => hour, :min   => min,   :sec => sec }
      end
    end
  end

  context 'with a string' do
    context "without hour, min and sec" do
      let(:hour) { 0 }
      let(:min)  { 0 }
      let(:sec)  { 0 }

      it_should_behave_like "a correct time" do
        let(:value) { "November #{day}th, #{year}" }
      end
    end

    context "with hour, min and sec" do
      it_should_behave_like "a correct time" do
        let(:value) { "November #{day}th, #{year}, #{hour}:#{min}:#{sec}" }
      end
    end
  end

  context 'with a non-date value' do
    let(:value) { '2999' }
    it { should equal(value) }
  end
end