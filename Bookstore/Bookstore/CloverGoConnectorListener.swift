//
//  CloverGoConnectorListener.swift
//  Bookstore
//
//  Created by Erica Solum on 11/25/17.
//  Copyright © 2017 Erica Solum. All rights reserved.
//

import Foundation
import UIKit
import GoConnector
import CloverGoReaderSDK
import clovergoclient

public class CloverGoConnectorListener: ICloverGoConnectorListener {
    // MARK: - Properties
    weak var cloverConnector:ICloverGoConnector?
    /// View Controller being displayed, used to present alert view controllers
    weak var viewController:UIViewController?
    
    public init(cloverConnector:ICloverGoConnector){
        self.cloverConnector = cloverConnector
    }
    
    // MARL: - Listener Methods
    public func onAidMatch(cardApplicationIdentifiers: [CLVModels.Payments.CardApplicationIdentifier]) {
        print("There's an aid match?")
    }
    
    public func onDevicesDiscovered(devices: [CLVModels.Device.GoDeviceInfo]) {
        print("Devices discovered")
    }
    
    public func onTransactionProgress(event: CLVModels.Payments.GoTransactionEvent) {
        print("There's a transaction event")
        print("\(event)")
    }
    
    public func onSignatureRequired() {
        print("Signature required")
    }
    
    public func onSendReceipt() {
        print("Send reciept")
    }
    
    public func onMultiplePaymentModesAvailable(paymentModes: [CLVModels.Payments.PaymentMode]) {
        print("Multiple payment modes available")
    }
    
    //Present VC to get payment data
    public func onKeyedCardDataRequired() {
        print("Keyed data is required")
        if let viewController = self.viewController {
            print("View controller present")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "paymentVC") as! PaymentViewController
            //self.viewController = vc
            viewController.present(vc, animated: true, completion: nil)
        }
    }
    
    // FIXME: This doesn't get called and I can't figure out why.
    public func onSaleResponse(_ response: SaleResponse) {
        print("There's a sale response!")
        print("response: \(response)")
        
        //Dismiss the Payment view controller then show alert with response
        self.viewController?.dismiss(animated: true, completion: {
            if response.success {
                // Theoretically a successful sale would add purchased book to Library
                let alert = UIAlertController(title: "Sale Alert", message: "Sale successful.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
                self.viewController?.present(alert, animated: true, completion: nil)
                
            } else {
                if response.result == .CANCEL {
                    let alert = UIAlertController(title: "Sale Alert", message: "Sale cancelled.", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
                    self.viewController?.present(alert, animated: true, completion: nil)
                    
                    //strongSelf.showMessage("Sale Canceled")
                } else if response.result == .FAIL {
                    let alert = UIAlertController(title: "Sale Alert", message: "Sale failed. \(response.message)", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
                    self.viewController?.present(alert, animated: true, completion: nil)
                    //strongSelf.showMessage("Sale Tx Failed - \(String(describing: response.message))", duration: 5)
                } else {
                    let alert = UIAlertController(title: "Sale Alert", message: "Sale failed. \(response.message)", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
                    self.viewController?.present(alert, animated: true, completion: nil)
                    //strongSelf.showMessage(response.result.rawValue);
                }
            }
        })
    }
    
    
    // Please ignore all the empty implementations
    public func onAuthResponse(_ authResponse: AuthResponse) {
        print("There's an auth response")
    }
    
    public func onPreAuthResponse(_ preAuthResponse: PreAuthResponse) {
        
    }
    
    public func onCapturePreAuthResponse(_ capturePreAuthResponse: CapturePreAuthResponse) {
        
    }
    
    public func onTipAdjustAuthResponse(_ tipAdjustAuthResponse: TipAdjustAuthResponse) {
        
    }
    
    public func onVoidPaymentResponse(_ voidPaymentResponse: VoidPaymentResponse) {
        print("Void payment response")
    }
    
    public func onRefundPaymentResponse(_ refundPaymentResponse: RefundPaymentResponse) {
        
    }
    
    public func onManualRefundResponse(_ manualRefundResponse: ManualRefundResponse) {
        
    }
    
    public func onCloseoutResponse(_ closeoutResponse: CloseoutResponse) {
        
    }
    
    public func onVerifySignatureRequest(_ signatureVerifyRequest: VerifySignatureRequest) {
        print("Verify signature response")
    }
    
    public func onVaultCardResponse(_ vaultCardResponse: VaultCardResponse) {
        
    }
    
    public func onDeviceActivityStart(_ deviceEvent: CloverDeviceEvent) {
        
    }
    
    public func onDeviceActivityEnd(_ deviceEvent: CloverDeviceEvent) {
        
    }
    
    public func onDeviceError(_ deviceErrorEvent: CloverDeviceErrorEvent) {
        
    }
    
    public func onDeviceConnected() {
        
    }
    
    public func onDeviceReady(_ merchantInfo: MerchantInfo) {
        
    }
    
    public func onDeviceDisconnected() {
        
    }
    
    public func onConfirmPaymentRequest(_ request: ConfirmPaymentRequest) {
        print("Request to confirm payment")
    }
    
    public func onTipAdded(_ message: TipAddedMessage) {
        
    }
    
    public func onPrintManualRefundReceipt(_ printManualRefundReceiptMessage: PrintManualRefundReceiptMessage) {
        
    }
    
    public func onPrintManualRefundDeclineReceipt(_ printManualRefundDeclineReceiptMessage: PrintManualRefundDeclineReceiptMessage) {
        
    }
    
    public func onPrintPaymentReceipt(_ printPaymentReceiptMessage: PrintPaymentReceiptMessage) {
        
    }
    
    public func onPrintPaymentDeclineReceipt(_ printPaymentDeclineReceiptMessage: PrintPaymentDeclineReceiptMessage) {
        
    }
    
    public func onPrintPaymentMerchantCopyReceipt(_ printPaymentMerchantCopyReceiptMessage: PrintPaymentMerchantCopyReceiptMessage) {
        
    }
    
    public func onPrintRefundPaymentReceipt(_ printRefundPaymentReceiptMessage: PrintRefundPaymentReceiptMessage) {
        
    }
    
    public func onRetrievePrintersResponse(_ retrievePrintersResponse: RetrievePrintersResponse) {
        
    }
    
    public func onPrintJobStatusResponse(_ printJobStatusResponse: PrintJobStatusResponse) {
        
    }
    
    public func onRetrievePendingPaymentsResponse(_ retrievePendingPaymentResponse: RetrievePendingPaymentsResponse) {
        print("There's a Retrieve Pending Payment response")
    }
    
    public func onReadCardDataResponse(_ readCardDataResponse: ReadCardDataResponse) {
        print("There's a Read Card Data response")
    }
    
    public func onCustomActivityResponse(_ customActivityResponse: CustomActivityResponse) {
        
    }
    
    public func onResetDeviceResponse(_ response: ResetDeviceResponse) {
        
    }
    
    public func onMessageFromActivity(_ response: MessageFromActivity) {
        print("There's a Message from activity")
    }
    
    public func onRetrievePaymentResponse(_ response: RetrievePaymentResponse) {
        print("There's a Retrieve Payment response")
    }
    
    public func onRetrieveDeviceStatusResponse(_ _response: RetrieveDeviceStatusResponse) {
        
    }
    
    
}
