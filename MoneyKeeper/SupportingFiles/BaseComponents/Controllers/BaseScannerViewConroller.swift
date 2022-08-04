//
//  BaseScannerViewConroller.swift
//  MoneyKeeper
//
//  Created by admin on 22/05/2019.
//  Copyright © 2019 ZYG. All rights reserved.
//

import UIKit
import SnapKit
import AVFoundation

// MARK: - BaseScannerDelegate
protocol BaseScannerDelegate: class {
    func prefersStatusBarHidden(_ scannerViewController: BaseScannerViewConroller) -> Bool
    func supportedInterfaceOrientations(_ scannerViewController: BaseScannerViewConroller) -> UIInterfaceOrientationMask
    func metaDataObjectTypes(_ scannerViewController: BaseScannerViewConroller) -> [AVMetadataObject.ObjectType]
    func overlayBackgroundColor(_ scannerViewController: BaseScannerViewConroller) -> UIColor
    func scanHelpDescription() -> String?
    func scanRect(_ scannerViewController: BaseScannerViewConroller) -> CGRect
    func scanFailed(_ scannerViewController: BaseScannerViewConroller)
    func scanSucced(_ scannerViewController: BaseScannerViewConroller, code: String, type: AVMetadataObject.ObjectType)
}

// MARK: - BaseScannerViewConroller
final class BaseScannerViewConroller: BaseViewController {
    
    //Properties
    public weak var delegate: BaseScannerDelegate?
    private var captureSession: AVCaptureSession!
    private var previewLayer: AVCaptureVideoPreviewLayer!
    
    //Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setRunning(self.captureSession.isRunning)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.setRunning(self.captureSession.isRunning)
    }
    
    override var prefersStatusBarHidden: Bool {
        return self.delegate?.prefersStatusBarHidden(self) ?? true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return self.delegate?.supportedInterfaceOrientations(self) ?? .portrait
    }
}

// MARK: - Publics
extension BaseScannerViewConroller {
    
    public func setRunning(_ isRunning: Bool) {
        if isRunning {
            self.captureSession.startRunning()
        } else {
            self.captureSession.stopRunning()
        }
    }
}

// MARK: - Privates
extension BaseScannerViewConroller {
    
    private func createUI() {
        self.view.backgroundColor = .black
        self.captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        
        let videoInput: AVCaptureDeviceInput
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if self.captureSession.canAddInput(videoInput) {
            self.captureSession.addInput(videoInput)
        } else {
            self.failed()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if self.captureSession.canAddOutput(metadataOutput) {
            self.captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = self.delegate?.metaDataObjectTypes(self)
        } else {
            self.failed()
            return
        }
        
        self.previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
        self.previewLayer.frame = view.layer.bounds
        self.previewLayer.videoGravity = .resizeAspectFill
        self.view.layer.addSublayer(self.previewLayer)
        
        let overlayView = UIView()
        overlayView.backgroundColor = self.delegate?.overlayBackgroundColor(self)
        self.view.addSubview(overlayView)
        overlayView.snp.makeConstraints(){
            $0.edges.equalToSuperview()
        }
        
        let rect: CGRect = self.delegate?.scanRect(self) ?? .zero
        let pathWithRadius = UIBezierPath(roundedRect:rect, byRoundingCorners:[.topRight, .topLeft, .bottomRight, .bottomLeft], cornerRadii: CGSize(width: 10, height: 10))
        let path = CGMutablePath()
        path.addPath(pathWithRadius.cgPath)
        path.addRect(self.view.frame)
        
        let maskLayer = CAShapeLayer()
        maskLayer.backgroundColor = UIColor.clear.cgColor
        maskLayer.path = path
        maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        overlayView.layer.mask = maskLayer
        
        let helpLabel = UILabel()
        helpLabel.text = self.delegate?.scanHelpDescription()
        helpLabel.numberOfLines = 0
        helpLabel.textAlignment = .center
        helpLabel.textColor = .white
        self.view.addSubview(helpLabel)
        helpLabel.snp.makeConstraints {
            $0.left.top.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.bottom.equalTo(self.view.snp.top).offset(rect.origin.y)
        }
        
        self.captureSession.startRunning()
    }
    
    private func failed() {
        self.delegate?.scanFailed(self)
        self.captureSession = nil
    }
    
    private func found(code: String, type: AVMetadataObject.ObjectType) {
        self.delegate?.scanSucced(self, code: code, type: type)
    }
}

// MARK: - AVCaptureMetadataOutputObjectsDelegate
extension BaseScannerViewConroller: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        self.captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            self.found(code: stringValue, type: readableObject.type)
        }
        
        self.dismiss(animated: true)
    }
}
