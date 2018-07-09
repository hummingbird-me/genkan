require 'rails_helper'
require 'with_thread_variable'

RSpec.describe WithThreadVariable do
  it 'should set the variable for the duration of the block' do
    described_class.with_thread_variable test: 'foo' do
      expect(Thread.current[:test]).to eq('foo')
    end
  end

  it 'should reset the variable to nil after the block' do
    described_class.with_thread_variable(test: 'foo') {}
    expect(Thread.current[:test]).not_to eq('foo')
  end
end
