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

  <div class="total-weight-input">
  <label for="totalWeight">Total Weight</label>
  <input type="number" name="totalWeight" id="totalWeight" value="" placeholder="Enter total weight">
  </div>

  <button class="btn btn-primary" name="button" type="submit">Tell me what I need!</button>

  </form>
  `
}

function weightForm() {
  return `
  <form class="weight" action="/weight-calculator" accept-charset="UTF-8" method="post"><input name="utf8" type="hidden" value="✓"><input type="hidden" name="authenticity_token" value="vQcYvxt5lo3M5tDNiIB5K8csY4FgmrCu7FmFsh1Ntj+bjaYGfU0ccQ6z1q8ZQqSCgCMvIpF9jDoJB/7gEip54g==">

  <div class="">
  <h4>Select your bar weight:</h4>

  <input type="radio" name="barWeight" id="barWeight_15" value="15">
  <label for="barWeight">15 lbs</label>

  <input type="radio" name="barWeight" id="barWeight_35" value="35">
  <label for="barWeight">35 lbs</label>

  <input type="radio" name="barWeight" id="barWeight_45" value="45" checked="checked">
  <label for="barWeight">45 lbs</label>
  <div>
  </form>

  <div class="">
  <p>Click the weight to add it to the bar</p>
  <div class="btn btn-primary reset">
  Reset
  </div>
  <div class="plateRack">
  <div class="stack">
    <div class="weight horizontal-plate-45">45</div>
    <div class="weight horizontal-plate-45">45</div>
    <div class="weight horizontal-plate-45">45</div>
    <div class="weight horizontal-plate-45">45</div>
    <div class="weight horizontal-plate-45">45</div>
  </div>
    <div class="stack">
      <div class="weight horizontal-plate-25">25</div>
      <div class="weight horizontal-plate-25">25</div>
      <div class="weight horizontal-plate-25">25</div>
      <div class="weight horizontal-plate-25">25</div>
      <div class="weight horizontal-plate-25">25</div>
    </div>

    <div class="stack">
      <div class="weight horizontal-plate-15">15</div>
      <div class="weight horizontal-plate-15">15</div>
      <div class="weight horizontal-plate-15">15</div>
      <div class="weight horizontal-plate-15">15</div>
      <div class="weight horizontal-plate-15">15</div>
    </div>

    <div class="stack">
      <div class="weight horizontal-plate-10">10</div>
      <div class="weight horizontal-plate-10">10</div>
      <div class="weight horizontal-plate-10">10</div>
      <div class="weight horizontal-plate-10">10</div>
      <div class="weight horizontal-plate-10">10</div>
    </div>

    <div class="stack">
      <div class="weight horizontal-plate-5">5</div>
      <div class="weight horizontal-plate-5">5</div>
      <div class="weight horizontal-plate-5">5</div>
      <div class="weight horizontal-plate-5">5</div>
      <div class="weight horizontal-plate-5">5</div>
    </div>

    <div class="stack">
      <div class="weight horizontal-plate-2-5">2.5</div>
      <div class="weight horizontal-plate-2-5">2.5</div>
      <div class="weight horizontal-plate-2-5">2.5</div>
      <div class="weight horizontal-plate-2-5">2.5</div>
      <div class="weight horizontal-plate-2-5">2.5</div>
    </div>

  </div>
  </div>

  `
}

document.addEventListener("DOMContentLoaded", function(event) {

  if (!document.querySelector(".weight_calculator")){
    return
  }
  const results = document.querySelector(".results")
  const plateButton = document.querySelector(".plates-div")
  const weightButton = document.querySelector(".weight-div")
  const formDiv = document.querySelector(".form")
  const barLeft = document.querySelector("#barLeft")
  const barRight = document.querySelector("#barRight")
  const weights = []
  let barWeight;

  function getBarWeight(barWeightSelections, weights) {
    for (var i = 0; i < barWeightSelections.length; i++) {
      const barWeightSelection = barWeightSelections[i]
      if (barWeightSelection.checked) {
        barWeight = barWeightSelection.value
      }
      barWeightSelection.addEventListener("change", function() {
        barWeight = barWeightSelection.value
        if (document.querySelector("form.weight")) {
          totalWeight(barWeight, weights)
        }
      })
    }
    return barWeight
  }

  function totalWeight(barWeight, weights) {
    let totalWeight = parseInt(barWeight)
    for (var i = 0; i < weights.length; i++) {
      const weight = weights[i]
      totalWeight += weight * 2
    }
    const html = `
    <h3>You have ${totalWeight} pounds!</h3>
    `
    results.textContent = ""
    results.insertAdjacentHTML("beforeend", html)
    buildBar(weights)
  }

  function clearPage() {
    formDiv.textContent = ""
    results.textContent = ""
    barLeft.textContent = ""
    barRight.textContent = ""
  }
  function buildBar(weights) {
    barLeft.textContent = ""
    barRight.textContent = ""
    for (var i = 0; i < weights.length; i++) {
      const weight = weights[i]
      if (weight == 2.5) {
        const html = `
        <div class="barPlate plate-2-5">2.5</div>
        `
        barLeft.insertAdjacentHTML("afterbegin", html)
        barRight.insertAdjacentHTML("beforeend", html)
      } else {
        const html = `
        <div class="barPlate plate-${weight}">${weight}</div>
        `
        barLeft.insertAdjacentHTML("afterbegin", html)
        barRight.insertAdjacentHTML("beforeend", html)
      }
    }
    const barPlates = document.querySelectorAll(".barPlate")
    if (barPlates) {
      for (var i = 0; i < barPlates.length; i++) {
        const barPlate = barPlates[i]
        barPlate.addEventListener("click", function(event) {
          const barPlateWeight = barPlate.textContent
          const plateIndex = weights.indexOf(barPlateWeight)
          weights.splice(plateIndex, 1)
          totalWeight(barWeight, weights)
        })
      }
    }
  }

  plateButton.addEventListener("click", function(event) {
    clearPage()
    const form = plateForm()
    formDiv.insertAdjacentHTML("afterbegin", form)
    const weightSelections = document.querySelectorAll('input[name="weight"]')
    if (weightSelections) {
      for (var i = 0; i < weightSelections.length; i++) {
        const weightSelection = weightSelections[i]
        if(weightSelection.checked) {
          weights.push(weightSelection.value)
        }
        weightSelection.addEventListener("change", function() {
          if (!this.checked) {
            const index = weights.indexOf(this.value)
            weights.splice(index, 1)
          } else {
            weights.push(this.value)
          }
        })
      }
    }

    const barWeightSelections = document.querySelectorAll('input[name="barWeight"]')
    if (barWeightSelections) {
      barWeight = getBarWeight(barWeightSelections)
    }

    const platesForm = document.querySelector('form.plates')
    if (platesForm) {
      platesForm.addEventListener("submit", function(event) {
        event.preventDefault()
        barLeft.textContent = ""
        barRight.textContent = ""
        const totalWeight = document.querySelector('input[name="totalWeight"]').value
        let plates = calcWeights(totalWeight, weights, barWeight)
        if (plates) {
          for(var weight in plates) {
            for (var i = 0; i < plates[weight]/2; i++) {
              if (weight == 2.5) {
                const html = `
                <div class="plate-2-5">2.5</div>
                `
                barLeft.insertAdjacentHTML("afterbegin", html)
                barRight.insertAdjacentHTML("beforeend", html)
              } else {
                const html = `
                <div class="plate-${weight}">${weight}</div>
                `
                barLeft.insertAdjacentHTML("beforeend", html)
                barRight.insertAdjacentHTML("afterbegin", html)
              }
            }
          }
        }
      })
    }

    function calcWeights(totalWeight, weights, barWeight) {
      results.textContent = ""
      if (!totalWeight) {
        const html = `
        <p class="error">Please enter a weight</p>
        `
        results.insertAdjacentHTML("afterbegin", html)
        return
      }
      weights = weights.sort(function(a,b){return b-a})
      const minWeight = weights[weights.length - 1]
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
      let calculatedWeight = 0
      for (var weight in plates) {
        const quantity = plates[weight]
        calculatedWeight += (parseFloat(weight)*parseInt(quantity))
      }
      calculatedWeight += parseInt(barWeight)
      if (calculatedWeight !== parseInt(totalWeight)) {
        const high = calculatedWeight + (minWeight * 2)
        const html = `<p class="error">Not possible!  Try ${calculatedWeight} or ${high}</p>`
        results.insertAdjacentHTML("afterbegin", html)
        return
      }
      return plates
    }
  })

  weightButton.addEventListener("click", function(event) {
    clearPage()
    const form = weightForm()
    const weights = []
    formDiv.insertAdjacentHTML("afterbegin", form)
    const barWeightSelections = document.querySelectorAll('input[name="barWeight"]')
    if (barWeightSelections) {
      barWeight = getBarWeight(barWeightSelections, weights)
      totalWeight(barWeight, weights)
    }

    const plates = document.querySelectorAll("div.weight")
    if (plates) {
      for (var i = 0; i < plates.length; i++) {
        const plate = plates[i]
        plate.addEventListener("click", function(event) {
          const weight = plate.textContent
          weights.push(weight)
          totalWeight(barWeight, weights)
        })
      }
    }
    const resetButton = document.querySelector(".reset")
    resetButton.addEventListener("click", function(event) {
      weights.splice(0, weights.length)
      totalWeight(barWeight, weights)
    })
  })
})
