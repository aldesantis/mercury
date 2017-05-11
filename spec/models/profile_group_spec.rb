RSpec.describe ProfileGroup do
  subject { build_stubbed(:profile_group) }

  it 'has a valid factory' do
    expect(subject).to be_valid
  end
end
