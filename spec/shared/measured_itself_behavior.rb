shared_examples_for 'measured itself' do
  it 'should return a MeasurementSet' do
    expect(@measurements).to be_kind_of(Yardstick::MeasurementSet)
  end

  it 'should be non-empty' do
    expect(@measurements).to_not be_empty
  end

  it 'should all be correct' do
    @measurements.each { |measurement| expect(measurement).to be_ok }
  end
end
