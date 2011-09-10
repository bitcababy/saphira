require "saphira/helpers/form_builder"
require "saphira/helpers/form_helper"

ActionView::Base.send :include, Saphira::Helpers::FormHelper
ActionView::Helpers::FormBuilder.send :include, Saphira::Helpers::FormBuilder