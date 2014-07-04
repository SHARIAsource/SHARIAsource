describe '/authors' do
  before do
    visit authors_path
  end

  it 'needs specs'
end

describe '/authors/:id' do
  before do
    visit author_path(123)
  end

  it 'needs specs'
end
