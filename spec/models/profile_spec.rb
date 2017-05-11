RSpec.describe Profile do
  subject { build_stubbed(:profile) }

  it 'has a valid factory' do
    expect(subject).to be_valid
  end
end
