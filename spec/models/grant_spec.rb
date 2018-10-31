RSpec.describe Grant, type: :model do
  it { should belong_to(:client) }
  it { should validate_presence_of(:client) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:expires_at) }

  describe '#expired?' do
    context 'for an grant with expires_at in the past' do
      it 'should return true' do
        grant = Grant.new(expires_at: 1.week.ago)
        expect(grant.expired?).to be_truthy
      end
    end

    context 'for a grant with expires_at in the future' do
      it 'should return false' do
        grant = Grant.new(expires_at: 1.month.from_now)
        expect(grant.expired?).to be_falsy
      end
    end
  end

  describe '#revoked?' do
    context 'for a grant with no revocation date' do
      it 'should return false' do
        grant = Grant.new(revoked_at: nil)
        expect(grant.revoked?).to be_falsy
      end
    end

    context 'for a grant with a revocation date in the past' do
      it 'should return true' do
        grant = Grant.new(revoked_at: 2.months.ago)
        expect(grant.revoked?).to be_truthy
      end
    end
  end

  describe '#revoke!' do
    context 'for an unrevoked grant' do
      subject { create(:grant, revoked_at: nil) }
      it 'should update the revoked_at timestamp' do
        Timecop.freeze do
          expect(subject.revoked_at).to be_nil
          subject.revoke!
          expect(subject.revoked_at).to eq(Time.now)
        end
      end
    end

    context 'for an already-revoked grant' do
      subject { create(:grant, revoked_at: 5.minutes.ago) }
      it 'should not update the revoked_at timestamp' do
        expect {
          subject.revoke!
        }.not_to(change { subject.revoked_at })
      end
    end
  end
end
