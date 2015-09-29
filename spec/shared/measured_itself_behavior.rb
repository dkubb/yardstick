# encoding: utf-8

shared_examples_for 'measured itself' do
  it 'returns a MeasurementSet' do
    expect(@measurements).to be_kind_of(Yardstick::MeasurementSet)
  end

  it 'is non-empty' do
    expect(@measurements).to_not be_empty
  end

  it 'is all correct' do
    @measurements.each { |measurement| expect(measurement).to be_ok }
  end
end
