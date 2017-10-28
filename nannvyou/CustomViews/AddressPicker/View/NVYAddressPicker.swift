//
//  NVYAddressPicker.swift
//  nanvyou
//
//  Created by NEWSTART on 2017/6/17.
//  Copyright © 2017年 MacMin-DLC0001. All rights reserved.
//

import UIKit

typealias AddressSurePickBlock = (_ address: String, _ ID: Int) -> Void
typealias AddressPickScrollBlock = (_ component: Int, _ row: Int) -> Void

class NVYAddressPicker: UIView, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var sureButton: UIButton!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
//    var provinceArr: NSMutableArray = ([NVYProviceModel]() as? NSMutableArray)!
//    var cityArr: NSMutableArray = ([NVYCityModel]() as? NSMutableArray)!
//    var areaArr: NSMutableArray = ([NVYAreaModel]() as? NSMutableArray)!
    
    var provinceArr: [NVYProviceModel]?
    var cityArr: [NVYCityModel]?
    var areaArr: [NVYAreaModel]?

    var surePick: AddressSurePickBlock?
    
    var pickComponent = 0
    
    var currentComponent = 0
    var currentRow = 0
    
    var currentProvinceID = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        

    }
    
    func show(view: UIView, components: Int) {
        
        pickComponent = components
        //获取地址信息信息
        NVYAddressDataTool.getFirstAddress { (Array) in
            
            let provinces = Array.first as? [NVYProviceModel]
            let cities = Array[1] as? [NVYCityModel]
            let areas = Array.last as? [NVYAreaModel]
            
            print(provinces!)
            
            print("----\(cities!)")
            
            print("====\(areas!)")
            
            self.provinceArr = provinces
            self.cityArr = cities
            self.areaArr = areas!
            
            view.addSubview(self)
            
            self.pickerView.reloadAllComponents()
            
            let province = provinces!.first
            self.currentProvinceID = (province?.Id)!
            
        }
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        removeFromSuperview()
    }
    
    @IBAction func sureAction(_ sender: UIButton) {
        removeFromSuperview()

        if (surePick != nil) {
            
            var name = ""
            var ID = 0
            if pickComponent > 2 {
                
                let province = provinceArr?[pickerView.selectedRow(inComponent: 0)]
                let city = cityArr?[pickerView.selectedRow(inComponent: 1)]
                let area = areaArr?[pickerView.selectedRow(inComponent: 2)]
                
                name = "\((province?.ProvinceName)!) \((city?.CityName)!) \((area?.AreaName)!)"
                ID = (area?.Id)!
    
            } else {
                let province = provinceArr?[pickerView.selectedRow(inComponent: 0)]
                let city = cityArr?[pickerView.selectedRow(inComponent: 1)]
                
                name = "\((province?.ProvinceName)!) \((city?.CityName)!)"
                ID = (city?.Id)!
            }
            surePick!(name, ID)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        removeFromSuperview()
    }
}

extension NVYAddressPicker {
    
    //MARK: - UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return pickComponent
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch component {
            case 0: return provinceArr!.count
           
            case 1: return cityArr!.count
            
            default: return areaArr!.count
        }

    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch component {
            case 0: return provinceArr?[row].ProvinceName
            
            case 1: return cityArr?[row].CityName
            
            default: return areaArr?[row].AreaName
        }

    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        currentComponent = component
        currentRow = row
        
        switch component {
            case 0:
                let province = provinceArr?[row]
                let provinceID = province?.Id
                currentProvinceID = provinceID!
                getCities(provinceId: provinceID!)
                break
            
            case 1:
                let city = cityArr?[row]
                let cityID = city?.Id
                getCities(provinceId: currentProvinceID, cityId: cityID!)
                break
            
            default: break
            
        }
    }
    
    func getCities(provinceId: Int) {
        
        NVYAddressDataTool.getAddressInfo(provinceID: provinceId, completion: { (Array) in

            let cities = Array.first as? [NVYCityModel]
            let areas = Array.last as? [NVYAreaModel]

            print("----\(cities!)")

            print("====\(areas!)")
            
            self.cityArr = cities
            self.areaArr = areas!
            
            self.pickerView.reloadComponent(1)
            
            if self.pickComponent > 2 {
                self.pickerView.reloadComponent(2)
            }

        })
    }
    
    
    func getCities(provinceId: Int, cityId: Int) {
        
        NVYAddressDataTool.getAddressInfo(provinceID: provinceId, cityID: cityId, completion: { (Array) in
            
            print("====\(Array)")
            
            self.areaArr = Array as? [NVYAreaModel]
            
            if self.pickComponent > 2 {
                self.pickerView.reloadComponent(2)
            }
        })
    }
    
}
