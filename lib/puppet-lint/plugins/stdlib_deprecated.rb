# frozen_string_literal: true

# A mapping between the old and new. A missing value indicates no automated
# replacement
STDLIB_DEPRECATED_METHODS = {
  'has_key' => nil, # Replacement has_key(x, y) is y in x
  'is_array' => nil, # Replacement is_array(x) is x =~ Array
  'shell_escape' => 'stdlib::shell_escape',
  'validate_legacy' => nil,
}.freeze

PuppetLint.new_check(:stdlib_deprecated) do
  def check
    tokens.each do |token|
      next unless token.type == :FUNCTION_NAME
      next unless STDLIB_DEPRECATED_METHODS.key?(token.value)

      notify :warning, {
        message: "Deprecated function #{token.value} used",
        line: token.line,
        column: token.column,
        token: token,
      }
    end
  end

  def fix(problem)
    token = problem[:token]

    if (replacement = STDLIB_DEPRECATED_METHODS[token.value])
      token.value = replacement
    else
      case token.value
      when 'has_key'
        fix_has_key(problem)
      when 'is_array'
        fix_is_array(problem)
      else
        raise PuppetLint::NoFix
      end
    end
  end

  def fix_has_key(problem)
    # TODO: Here you have to figure out some things in context
    # Possible cases:
    # * x.has_key(y) => y in x
    # * has_key(x, y) => y in x
    if token&.prev_code_token&.type == :DOT && token&.prev_code_token&.prev_code_token&.type == :NAME
      # x.function
      raise PuppetLint::NoFix
    elsif token&.next_code_token&.type == :LPAREN
      # function(x)
      raise PuppetLint::NoFix
    end
  end

  def fix_is_array(problem)
    raise PuppetLint::NoFix
  end
end
