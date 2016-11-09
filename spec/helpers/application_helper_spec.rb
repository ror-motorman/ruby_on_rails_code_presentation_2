require 'rails_helper'

describe ApplicationHelper do
  describe '#path_to_js_for_current_page' do
    xit 'returns path to js file for current page' do
      expect(helper).to receive(:controller_name) { 'users' }
      expect(helper).to receive(:action_name) { 'work_statistics' }

      expect(helper.path_to_js_for_current_page).to eq('pages/users/work_statistics')
    end

    it 'returns blank string when no js file for current page' do
      expect(helper.path_to_js_for_current_page).to eq('')
    end
  end

  it '#title return title for current controller' do
    expect(helper).to receive(:controller_name) { 'users' }
    expect(helper.title).to eq('Users')
  end

  describe '#active_class_for' do
    it 'return "active" when current controller name equal expected name' do
      expect(helper).to receive(:controller_name) { 'users' }
      expect(helper.active_class_for('users')).to eq('active')
    end

    it 'return empty string when current controller name not equal expected name' do
      expect(helper).to receive(:controller_name) { 'users' }
      expect(helper.active_class_for('test')).to eq('')
    end
  end
end
