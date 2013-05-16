shared_examples_for 'measured itself' do
  it 'should return a MeasurementSet' do
    @measurements.should be_kind_of(Yardstick::MeasurementSet)
  end

  it 'should be non-empty' do
    @measurements.should_not be_empty
  end

  it 'should all be correct' do
    @measurements.each { |measurement| measurement.should be_ok }
  end
end
