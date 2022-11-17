import { Controller } from "@hotwired/stimulus"
import Reveal from 'stimulus-reveal-controller'

// Connects to data-controller="reveal"
export default class extends Controller {
  static targets = ["hide_pm_hours", 'hide_inputs', "hours", "checkbox", 'checkbox_close']

  connect() {
    this.toggleBreak()
    this.toggleClose()
  }

  // Hiding and Disabling Afternoon hours if Checkbox lunch_break checked
  toggleBreak() {
    this.toggleForm(this.hide_pm_hoursTarget, this.checkboxTarget)
    this.toggleValidation(this.hide_pm_hoursTarget, this.hoursTargets, this.checkboxTarget)
  }

  // Hiding and Resetting Hours in Form if Checkbox closed checked (opposite of toggleForm())
  toggleClose() {
    if(!this.checkbox_closeTarget.checked) {
      this.hide_inputsTarget.classList.remove('hidden');
    } else if(this.checkbox_closeTarget.checked) {
      this.hide_inputsTarget.classList.add('hidden');
    }
    // this.toggleForm(this.hide_inputsTarget, this.checkbox_closeTarget)
  }

  // Generic toggleForm
  toggleForm(item, checkbox) {
    if(checkbox.checked) {
      item.classList.remove('hidden');
    } else if(!checkbox.checked) {
      item.classList.add('hidden');
    }
  }

  // Generic toggleValidation - disabling form-inputs
  toggleValidation(item, input_form, checkbox) {
    if(checkbox.checked) {
      input_form.forEach(i => i.disabled = false);
    } else if(!checkbox.checked) {
      input_form.forEach(i => i.disabled = true);
    }
  }
}
