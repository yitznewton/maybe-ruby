require 'maybe'

describe 'Maybe' do
  describe '#value_or' do
    context 'with value' do
      context 'with alternative given' do
        it 'returns same value when exists' do
          value = 'a'
          alternative = 'b'
          maybe = Maybe.new(value)
          expect(maybe.value_or alternative).to eq value
        end

        it 'returns same value when false' do
          value = false
          alternative = 'b'
          maybe = Maybe.new(value)
          expect(maybe.value_or alternative).to eq value
        end

        it 'returns alternative value when nil' do
          alternative = 'b'
          maybe = Maybe.new(nil)
          expect(maybe.value_or alternative).to eq alternative
        end
      end
    end

    context 'with callback' do
      it 'returns same value when exists' do
        value = 'a'
        result = Maybe.new(value).value_or { 5 }
        expect(result).to eq value
      end

      it 'returns callback result when nil' do
        alternative = 5
        result = Maybe.new(nil).value_or { alternative }
        expect(result).to eq alternative
      end
    end

    context 'with neither value nor callback' do
      it 'raises error' do
        maybe = Maybe.new(nil)
        expect { maybe.value_or }.to raise_error ArgumentError
      end
    end
  end

  describe '#select' do
    context 'with non-nil' do
      it 'executes block and returns a loaded Maybe' do
        value = 5
        block = proc { |x| x + 1 }
        maybe = Maybe.new(value)
        result = maybe.select(&block)
        expect(result).to eq block.call(value)
      end
    end

    context 'with nil' do
      it 'returns a nil Maybe' do
        maybe = Maybe.new(nil)
        alternative = 5
        result = maybe.select { |x| x + 1 }
        expect(result.value_or alternative).to eq alternative
      end
    end
  end
end
