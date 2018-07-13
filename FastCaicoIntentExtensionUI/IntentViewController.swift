//
//  IntentViewController.swift
//  FastCaicoIntentExtensionUI
//
//  Created by Yuri on 12/07/18.
//  Copyright © 2018 academy. All rights reserved.
//

import IntentsUI

// As an example, this extension's Info.plist has been configured to handle interactions for INSendMessageIntent.
// You will want to replace this or add other intents as appropriate.
// The intents whose interactions you wish to handle must be declared in the extension's Info.plist.

// You can test this example integration by saying things to Siri like:
// "Send a message using <myApp>"

class IntentViewController: UIViewController, INUIHostedViewControlling {
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodTitleLabel: UILabel!
    @IBOutlet weak var garnishesLabel: UILabel!
    @IBOutlet weak var orderPriceLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func configureView(for parameters: Set<INParameter>, of interaction: INInteraction, interactiveBehavior: INUIInteractiveBehavior, context: INUIHostedViewContext, completion: @escaping (Bool, Set<INParameter>, CGSize) -> Void) {
        guard let orderIntent = interaction.intent as? OrderFoodIntent else {
            return
        }
        foodTitleLabel.text = orderIntent.dish?.displayString
        garnishesLabel.text = orderIntent.garnishes
        orderPriceLabel.text = String(format: "R$ %.2f", orderIntent.price!.floatValue).replacingOccurrences(of: ".", with: ",")
        if let orderImage = orderIntent.image {
            foodImageView.image = UIImage(named: orderImage)
        }
        completion(true, parameters, self.desiredSize)
    }
    
    var desiredSize: CGSize {
        let width = self.extensionContext?.hostedViewMaximumAllowedSize.width ?? 320
        let height: CGFloat = 120
        return CGSize(width: width, height: height)
    }
    
}
