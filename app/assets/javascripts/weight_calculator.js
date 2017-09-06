function plateForm() {
  return `
  <form class="plates" action="/weight-calculator" accept-charset="UTF-8" method="post"><input name="utf8" type="hidden" value="✓"><input type="hidden" name="authenticity_token" value="vQcYvxt5lo3M5tDNiIB5K8csY4FgmrCu7FmFsh1Ntj+bjaYGfU0ccQ6z1q8ZQqSCgCMvIpF9jDoJB/7gEip54g==">

  <p>Please select the weights you have available to you</p>
  <div class="">
  <input type="checkbox" name="weight" id="weight" value="45" checked="checked">
  <label for="weight">45 lbs</label>

  <input type="checkbox" name="weight" id="weight" value="25" checked="checked">
  <label for="weight">25 lbs</label>

  <input type="checkbox" name="weight" id="weight" value="15" checked="checked">
  <label for="weight">15 lbs</label>

  <input type="checkbox" name="weight" id="weight" value="10" checked="checked">
  <label for="weight">10 lbs</label>

  <input type="checkbox" name="weight" id="weight" value="5" checked="checked">
  <label for="weight">5 lbs</label>

  <input type="checkbox" name="weight" id="weight" value="2.5" checked="checked">
  <label for="weight">2.5 lbs</label>
  </div>

  <div class="">
  <p>Select your bar weight:</p>

  <input type="radio" name="barWeight" id="barWeight_15" value="15">
  <label for="barWeight">15 lbs</label>

  <input type="radio" name="barWeight" id="barWeight_35" value="35">
  <label for="barWeight">35 lbs</label>

  <input type="radio" name="barWeight" id="barWeight_45" value="45" checked="checked">
  <label for="barWeight">45 lbs</label>
  <div>

  <div class="">
  <label for="totalWeight">Total Weight</label>
  <input type="number" name="totalWeight" id="totalWeight" value="" placeholder="Enter total weight">
  </div>

  <button name="button" type="submit">Tell me what I need!</button>

  </form>
  `
}

function weightForm() {
  return `
  <form class="weight" action="/weight-calculator" accept-charset="UTF-8" method="post"><input name="utf8" type="hidden" value="✓"><input type="hidden" name="authenticity_token" value="vQcYvxt5lo3M5tDNiIB5K8csY4FgmrCu7FmFsh1Ntj+bjaYGfU0ccQ6z1q8ZQqSCgCMvIpF9jDoJB/7gEip54g==">

  <div class="">
  <p>Select your bar weight:</p>

  <input type="radio" name="barWeight" id="barWeight_15" value="15">
  <label for="barWeight">15 lbs</label>

  <input type="radio" name="barWeight" id="barWeight_35" value="35">
  <label for="barWeight">35 lbs</label>

  <input type="radio" name="barWeight" id="barWeight_45" value="45" checked="checked">
  <label for="barWeight">45 lbs</label>
  <div>

  <div class="">
  <p>Click the weight to add it to the bar</p>
  <div class="weight" id="45">
  45
  </div>

  <div class="weight" id="25">
  25
  </div>

  <div class="weight" id="15">
  15
  </div>

  <div class="weight" id="10">
  10
  </div>

  <div class="weight" id="5">
  5
  </div>

  <div class="weight" id="2.5">
  2.5
  </div>
  </div>

</form>

  `
}

function getBarWeight(barWeightSelections) {
  for (var i = 0; i < barWeightSelections.length; i++) {
    const barWeightSelection = barWeightSelections[i]
    if (barWeightSelection.checked) {
      barWeight = barWeightSelection.value
      console.log(barWeight);
    }
    barWeightSelection.addEventListener("change", function() {
      barWeight = barWeightSelection.value
      console.log(barWeight);
    })
  }
  return barWeight
}



document.addEventListener("DOMContentLoaded", function(event) {
  const results = document.querySelector(".results")
  const plateButton = document.querySelector(".plates-div")
  const weightButton = document.querySelector(".weight-div")
  const formDiv = document.querySelector(".form")
  const weights = []
  let barWeight;

  plateButton.addEventListener("click", function(event) {
    formDiv.textContent = ""
    results.textContent = ""
    const form = plateForm()
    formDiv.insertAdjacentHTML("afterbegin", form)
    const weightSelections = document.querySelectorAll('input[name="weight"]')
    if (weightSelections) {
      for (var i = 0; i < weightSelections.length; i++) {
        const weightSelection = weightSelections[i]
        if(weightSelection.checked) {
          weights.push(weightSelection.value)
          console.log(weights);
        }
        weightSelection.addEventListener("change", function() {
          if (!this.checked) {
            const index = weights.indexOf(this.value)
            weights.splice(index, 1)
            console.log(weights);
          } else {
            weights.push(this.value)
            console.log(weights);
          }
        })
      }
    }
    const barWeightSelections = document.querySelectorAll('input[name="barWeight"]')
    if (barWeightSelections) {
      for (var i = 0; i < barWeightSelections.length; i++) {
        const barWeightSelection = barWeightSelections[i]
        if (barWeightSelection.checked) {
          barWeight = barWeightSelection.value
          console.log(barWeight);
        }
        barWeightSelection.addEventListener("change", function() {
          barWeight = barWeightSelection.value
          console.log(barWeight);
        })
      }
    }

    const platesForm = document.querySelector('form.plates')
    if (platesForm) {
      platesForm.addEventListener("submit", function(event) {
        event.preventDefault()
        const totalWeight = document.querySelector('input[name="totalWeight"]').value
        let plates = calcWeights(totalWeight, weights, barWeight)
        for(var weight in plates) {
          const html = `
          <p>You need ${plates[weight]} ${weight} lb plates</p>
          `
          results.insertAdjacentHTML("beforeend", html)
        }
      })
    }

    function calcWeights(totalWeight, weights, barWeight) {
      results.textContent = ""
      weights = weights.sort(function(a,b){return b-a})
      let remainingWeight = totalWeight -  barWeight
      let plates = {}
      for (let i=0; i<weights.length; i++) {
        const weight = weights[i]
        const doubleWeight = weight * 2
        if(remainingWeight >= doubleWeight) {
          plates[weight] = Math.floor(remainingWeight/doubleWeight) * 2
          remainingWeight = remainingWeight%doubleWeight
        }
      }
      return plates
    }
  })

  weightButton.addEventListener("click", function(event) {
    formDiv.textContent = ""
    results.textContent = ""
    const form = weightForm()
    const weights = []
    formDiv.insertAdjacentHTML("afterbegin", form)
    const barWeightSelections = document.querySelectorAll('input[name="barWeight"]')
    for (var i = 0; i < barWeightSelections.length; i++) {
      const barWeightSelection = barWeightSelections[i]
      if (barWeightSelection.checked) {
        barWeight = barWeightSelection.value
        console.log(barWeight);
        totalWeight(barWeight, weights)
      }
      barWeightSelection.addEventListener("change", function() {
        barWeight = barWeightSelection.value
        console.log(barWeight);
        totalWeight(barWeight, weights)
      })
    }
    const plates = document.querySelectorAll("div.weight")
    if (plates) {
      for (var i = 0; i < plates.length; i++) {
        const plate = plates[i]
        plate.addEventListener("click", function(event) {
          const plateWeight = parseFloat(plate.textContent) * 2
          console.log(plateWeight);
          weights.push(plateWeight)
          totalWeight(barWeight, weights)
        })
      }
    }
    function totalWeight(barWeight, weights) {
      let totalWeight = parseInt(barWeight)
      for (var i = 0; i < weights.length; i++) {
        const weight = weights[i]
        totalWeight += weight
      }
      const html = `
      You have ${totalWeight} pounds!
      `
      results.textContent = ""
      results.insertAdjacentHTML("beforeend", html)
    }
  })
})
