//
//  ViewController.swift
//  DollarsPerSecond
//
//  Created by Kevin Tanner on 9/2/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    // MARK: - Outlets
    @IBOutlet weak var annualSalaryTextField: UITextField!
    @IBOutlet weak var calculatedDollarsPerSecondLabel: UILabel!
    @IBOutlet weak var calculateDollarsPerMinuteLabel: UILabel!
    @IBOutlet weak var calculateDollarsPerHourLabel: UILabel!
    @IBOutlet weak var calculateDollarsPerDayLabel: UILabel!
    @IBOutlet weak var calculateDollarsPerWeekLabel: UILabel!
    @IBOutlet weak var calculateDollarsPerMonthLabel: UILabel!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        annualSalaryTextField.keyboardType = .numberPad
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    // MARK: - Actions
    @IBAction func calculateDollarsButtonTapped(_ sender: Any) {
        
        guard let annualSalaryString = annualSalaryTextField.text,
            let annualSalary = Double(annualSalaryString) else { return }
        
        calculateDollarsHelper(annualSalary: Double(annualSalary))
    }
    
    // MARK: - Custom Methods
    
    func calculateCaliforniaIncomeTaxBracket(annualSalary: Double) -> Double {

        // Based on information found here: https://smartasset.com/taxes/california-tax-calculator
        
        switch annualSalary {
        case let taxBracket where taxBracket < 8544.00:
            return 0.01
        case let taxBracket where taxBracket >= 8544.00 && taxBracket < 20255.00:
            return 0.02
        case let taxBracket where taxBracket >= 20255.00 && taxBracket < 31969.00:
            return 0.04
        case let taxBracket where taxBracket >= 31969.00 && taxBracket < 44377.00:
            return 0.06
        case let taxBracket where taxBracket >= 44377.00 && taxBracket < 56085.00:
            return 0.08
        case let taxBracket where taxBracket >= 56085.00 && taxBracket < 286492.00:
            return 0.093
        case let taxBracket where taxBracket >= 286492.00 && taxBracket < 343788.00:
            return 0.103
        case let taxBracket where taxBracket >= 343788.00 && taxBracket < 572980.00:
            return 0.113
        case let taxBracket where taxBracket >= 572980.00 && taxBracket <= 1000000.00:
            return 0.123
        default:
            return 0.133
        }
    }
    
    func calculateFederalTaxBracketBaseAmountOwed(annualSalary: Double) -> Double {

        // Based on information found here: https://www.quickenloans.com/blog/federal-income-tax-brackets
        
        switch annualSalary {
        case let taxBracket where taxBracket < 9700.00:
            return 0.00
        case let taxBracket where taxBracket >= 9700.00 && taxBracket < 39475.00:
            return 970.00
        case let taxBracket where taxBracket >= 39475.00 && taxBracket < 84200.00:
            return 4543.00
        case let taxBracket where taxBracket >= 84200.00 && taxBracket < 160725.00:
            return 14382.50
        case let taxBracket where taxBracket >= 160725.00 && taxBracket < 204100.00:
            return 32748.50
        case let taxBracket where taxBracket >= 204100.00 && taxBracket <= 510300.00:
            return 46628.50
        default:
            return 153798.50
        }
    }
    
    func calculateFederalTaxBracketPercentage(annualSalary: Double) -> Double {
        
        // Based on information found here: https://www.quickenloans.com/blog/federal-income-tax-brackets
        
        switch annualSalary {
        case let taxBracket where taxBracket < 9700.00:
            return 0.10
        case let taxBracket where taxBracket >= 9700.00 && taxBracket < 39475.00:
            return 0.12
        case let taxBracket where taxBracket >= 39475.00 && taxBracket < 84200.00:
            return 0.22
        case let taxBracket where taxBracket >= 84200.00 && taxBracket < 160725.00:
            return 0.24
        case let taxBracket where taxBracket >= 160725.00 && taxBracket < 204100.00:
            return 0.32
        case let taxBracket where taxBracket >= 204100.00 && taxBracket <= 510300.00:
            return 0.35
        default:
            return 0.37
        }
    }
    
    func calculateFederalTaxBracketAmountOver(annualSalary: Double) -> Double {
        
        // Based on information found here: https://www.quickenloans.com/blog/federal-income-tax-brackets
        
        switch annualSalary {
        case let taxBracket where taxBracket < 9700.00:
            return 0.00
        case let taxBracket where taxBracket >= 9700.00 && taxBracket < 39475.00:
            return 9700.00
        case let taxBracket where taxBracket >= 39475.00 && taxBracket < 84200.00:
            return 39475.00
        case let taxBracket where taxBracket >= 84200.00 && taxBracket < 160725.00:
            return 84200.00
        case let taxBracket where taxBracket >= 160725.00 && taxBracket < 204100.00:
            return 160725.00
        case let taxBracket where taxBracket >= 204100.00 && taxBracket <= 510300.00:
            return 204100.00
        default:
            return 510300.00
        }
    }
    
    func calculateDollarsHelper(annualSalary: Double) {
        
        let yourCaliforniaTaxBracket = calculateCaliforniaIncomeTaxBracket(annualSalary: annualSalary)
        
        let californiaTaxesOwed = annualSalary * yourCaliforniaTaxBracket

        let yourFederalTaxBracketPercentage = calculateFederalTaxBracketPercentage(annualSalary: annualSalary)
        let yourFederalTaxBracketBaseAmountOwed = calculateFederalTaxBracketBaseAmountOwed(annualSalary: annualSalary)
        let yourFederalTaxBracketAmountOver = calculateFederalTaxBracketAmountOver(annualSalary: annualSalary)
        
        let federalTaxesOwed = yourFederalTaxBracketBaseAmountOwed + ((annualSalary - yourFederalTaxBracketAmountOver) * yourFederalTaxBracketPercentage)
        
        let annualSalaryAfterTaxes = annualSalary - californiaTaxesOwed - federalTaxesOwed
        
        
        let typicalDaysWorkedAYear:Double = 237 // weekdays(260), 2 weeks vacation(14), and us holidays(9)
        let typicalHoursWorkedPerWorkDaysAYear:Double = 237 * 8
        let typicalMinutesWorkedPerWorkDaysAYear:Double = 237 * 8 * 60
        let typicalSecondsWorkedPerWorkDaysAYear:Double = 237 * 8 * 60 * 60
        let typicalMonthsWorkedAYear:Double = 11.25
        let typicalWeeksWorkedAYear:Double = 49 // 2 weeks vacation + 1 week of holidays
        
        let seconds = annualSalaryAfterTaxes/typicalSecondsWorkedPerWorkDaysAYear
        let secondsFormatted = String(format: "$%.2f", seconds)
        
        let minutes = annualSalaryAfterTaxes/typicalMinutesWorkedPerWorkDaysAYear
        let minutesFormatted = String(format: "$%.2f", minutes)
        
        let hours = annualSalaryAfterTaxes/typicalHoursWorkedPerWorkDaysAYear
        let hoursFormatted = String(format: "$%.2f", hours)
        
        let days = annualSalaryAfterTaxes/typicalDaysWorkedAYear
        let daysFormatted = String(format: "$%.2f", days)
        
        let weeks = annualSalaryAfterTaxes/typicalWeeksWorkedAYear
        let weeksFormatted = String(format: "$%.2f", weeks)
        
        let months = annualSalaryAfterTaxes/typicalMonthsWorkedAYear
        let monthsFormatted = String(format: "$%.2f", months)
        
        calculatedDollarsPerSecondLabel.text = secondsFormatted
        calculateDollarsPerMinuteLabel.text = minutesFormatted
        calculateDollarsPerHourLabel.text = hoursFormatted
        calculateDollarsPerDayLabel.text = daysFormatted
        calculateDollarsPerWeekLabel.text = weeksFormatted
        calculateDollarsPerMonthLabel.text = monthsFormatted
    }
}

