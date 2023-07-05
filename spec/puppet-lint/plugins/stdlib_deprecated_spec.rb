# frozen_string_literal: true

require 'spec_helper'

describe 'stdlib_deprecated' do
  let(:msg) { /Deprecated function .+ used/ }

  context 'without deprecated functions' do
    let(:code) { "strip(' a string ')" }

    it 'detects no problems' do
      expect(problems).to have(0).problems
    end
  end

  context 'with a deprecated function using parenthesis' do
    let(:code) { 'is_array(x)' }

    it 'detects a single problem' do
      expect(problems).to have(1).problem
    end

    it 'creates a warning' do
      expect(problems).to contain_warning('Deprecated function is_array used').on_line(1).in_column(1)
    end
  end

  context 'with a deprecated function using dot notation' do
    let(:code) { 'x.is_array()' }

    it 'detects a single problem' do
      expect(problems).to have(1).problem
    end

    it 'creates a warning' do
      expect(problems).to contain_warning('Deprecated function is_array used').on_line(1).in_column(3)
    end
  end

  # TODO: this is not detected as a function now
  context 'with a deprecated function using dot notation' do
    let(:code) { 'x.is_array' }

    it 'detects a single problem' do
      expect(problems).to have(1).problem
    end

    it 'creates a warning' do
      expect(problems).to contain_warning('Deprecated function is_array used').on_line(1).in_column(3)
    end
  end

  context 'with fix enabled' do
    before do
      PuppetLint.configuration.fix = true
    end

    after do
      PuppetLint.configuration.fix = false
    end

    context 'with shell_escape method' do
      let(:code) { 'shell_escape(x)' }

      it 'detects a single problem' do
        expect(problems).to have(1).problem
      end

      it 'fixes the manifest' do
        expect(problems).to contain_fixed('Deprecated function shell_escape used').on_line(1).in_column(1)
      end

      it 'replaces with the name spaced version' do
        expect(manifest).to eq('stdlib::shell_escape(x)')
      end
    end
  end
end
