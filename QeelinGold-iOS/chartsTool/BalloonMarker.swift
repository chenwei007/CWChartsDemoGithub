//
//  BalloonMarker.swift
//  ChartsDemo
//
//  Copyright 2015 Daniel Cohen Gindi & Philipp Jahoda
//  A port of MPAndroidChart for iOS
//  Licensed under Apache License 2.0
//
//  https://github.com/danielgindi/Charts
//

import Foundation
import Charts


open class BalloonMarker: MarkerImage
{
    open var leftLabel : UILabel?
    open var rightLabel : UILabel?
    open var color: UIColor?
    open var arrowSize = CGSize(width: 0, height: 0)
    open var font: UIFont?
    open var textColor: UIColor?
    open var insets = UIEdgeInsets()
    open var minimumSize = CGSize()
    open var context: CGContext?
    open var clickPoint: CGPoint = CGPoint()
    
    fileprivate var labelnsLeft: NSString?
    fileprivate var _labelSizeLeft: CGSize = CGSize()
    fileprivate var labelnsRight: NSString?
    fileprivate var _labelSizeRight: CGSize = CGSize()
    fileprivate var labelnsBotton: NSString?
    fileprivate var _labelSizeBotton: CGSize = CGSize()
    fileprivate var _paragraphStyle: NSMutableParagraphStyle?
    fileprivate var _drawAttributes = [String : AnyObject]()
    
    public init(color: UIColor, font: UIFont, textColor: UIColor, insets: UIEdgeInsets)
    {
        super.init()
        
        self.color = color
        self.font = font
        self.textColor = textColor
        self.insets = insets
        
        _paragraphStyle = NSParagraphStyle.default.mutableCopy() as? NSMutableParagraphStyle
        _paragraphStyle?.alignment = .center
    }
    open override func offsetForDrawing(atPoint point: CGPoint) -> CGPoint
    {
        let size = self.size
        var point = point
        point.x -= size.width / 2.0
        point.y -= size.height
        return super.offsetForDrawing(atPoint: point)
    }
    
    open override func draw(context: CGContext, point: CGPoint)
    {
        if labelnsLeft == nil
        {
            return
        }
        clickPoint = point
        let offset = self.offsetForDrawing(atPoint: point)
        let size = self.size
        
        var rect = CGRect(
            origin: CGPoint(
                x: point.x + offset.x,
                y: point.y + offset.y),
            size: size)
        rect.origin.x -= size.width / 2.0
        rect.origin.y -= size.height
        
        context.saveGState()
        
        if let color = color
        {
            context.setLineWidth(3.0)
            context.setFillColor(color.cgColor)
            context.setStrokeColor((self.textColor?.cgColor)!)
            context.beginPath()
            context.move(to: CGPoint(
                x: 33,
                y: rect.origin.y + arrowSize.height + rect.size.height / 2 +  rect.size.height / 4))
            context.addLine(to: CGPoint(
                x: 33 + rect.size.width,
                y: rect.origin.y + arrowSize.height + rect.size.height / 2 +  rect.size.height / 4))
            context.addLine(to: CGPoint(
                x: 33 + rect.size.width,
                y: rect.origin.y + arrowSize.height + rect.size.height +  rect.size.height / 4))
            context.addLine(to: CGPoint(
                x: 33,
                y: rect.origin.y + arrowSize.height + rect.size.height +  rect.size.height / 4))
            context.addLine(to: CGPoint(
                x: 33,
                y: rect.origin.y + arrowSize.height + rect.size.height / 2 +  rect.size.height / 4))
            context.fillPath()
            context.strokePath()
            
            rect.origin.y += self.insets.top
            rect.size.height -= self.insets.top + self.insets.bottom
            rect.origin.x = 33
            rect.origin.y = rect.origin.y + arrowSize.height + rect.size.height / 2 +  rect.size.height / 4 + self.insets.top
            
            UIGraphicsPushContext(context)
            labelnsLeft?.draw(in: rect, withAttributes: _drawAttributes)
            UIGraphicsPopContext()
            
            context.setFillColor(color.cgColor)
            context.beginPath()
            context.move(to: CGPoint(
                x: (self.chartView!.bounds.size.width) - 37 - rect.size.width,
                y: rect.origin.y ))
            context.addLine(to: CGPoint(
                x: (self.chartView!.bounds.size.width) - 37 - rect.size.width + rect.size.width,
                y: rect.origin.y))
            context.addLine(to: CGPoint(
                x: (self.chartView!.bounds.size.width) - 37 - rect.size.width + rect.size.width,
                y: rect.origin.y + rect.size.height / 2))
            context.addLine(to: CGPoint(
                x: (self.chartView!.bounds.size.width) - 37 - rect.size.width ,
                y: rect.origin.y + rect.size.height / 2))
            context.addLine(to: CGPoint(
                x: (self.chartView!.bounds.size.width) - 37 - rect.size.width,
                y: rect.origin.y ))
            context.fillPath()
            
            rect.size.height -= self.insets.top + self.insets.bottom
            rect.origin.x = (self.chartView!.bounds.size.width) - 37 - rect.size.width
            rect.origin.y = rect.origin.y + arrowSize.height + self.insets.top
            
            UIGraphicsPushContext(context)
            labelnsRight?.draw(in: rect, withAttributes: _drawAttributes)
            UIGraphicsPopContext()
            
            context.setFillColor(color.cgColor)
            context.beginPath()
            context.move(to: CGPoint(
                x: clickPoint.x - rect.size.width / 2,
                y: (self.chartView?.bounds.size.height)! - 28))
            context.addLine(to: CGPoint(
                x: clickPoint.x - rect.size.width / 2 + rect.size.width,
                y: (self.chartView?.bounds.size.height)! - 28))
            context.addLine(to: CGPoint(
                x: clickPoint.x - rect.size.width / 2 + rect.size.width,
                y: (self.chartView?.bounds.size.height)! - 13))
            context.addLine(to: CGPoint(
                x: clickPoint.x - rect.size.width / 2 ,
                y: (self.chartView?.bounds.size.height)! - 13))
            context.addLine(to: CGPoint(
                x: clickPoint.x - rect.size.width / 2,
                y: (self.chartView?.bounds.size.height)! - 28))
            context.fillPath()
            
            rect.size.height -= self.insets.top + self.insets.bottom
            rect.origin.x = clickPoint.x - rect.size.width / 2 + arrowSize.height + self.insets.top
            rect.origin.y = (self.chartView?.bounds.size.height)! - 28
            
            UIGraphicsPushContext(context)
            labelnsBotton?.draw(in: rect, withAttributes: _drawAttributes)
            UIGraphicsPopContext()
            context.restoreGState()


        }
    }
    
    open override func refreshContent(entry: ChartDataEntry, highlight: Highlight)
    {
        if entry is CandleChartDataEntry {
            //            NSDictionary *dic = @{
            //                @"time":turnStr,
            //                @"open":@(open),
            //                @"close":@(close),
            //                @"high":@(high),
            //                @"low":@(low)
            //            };
            let CandlechartEntryDic = entry.data
            let time = CandlechartEntryDic?["time"] as? NSString ?? ""
            let open = CandlechartEntryDic?["open"] as? NSString ?? ""
            let close = CandlechartEntryDic?["close"] as? NSString ?? ""
            let high = CandlechartEntryDic?["high"] as? NSString ?? ""
            let low = CandlechartEntryDic?["low"] as? NSString ?? ""
//            let resultString: String = "时间:  \(time) \n开盘:  \(open)\n收盘: \(close)\n最高:  \(high)\n最低:  \(low)"
            let resultString: String = "时间:  \(time)"
            setLabelLeft(resultString as String)
            
        } else if entry is  ChartDataEntry{
            //        let className: AnyClass = entry.classForCoder
            //        NSDictionary *dic = @{
            //            @"datasY" : @(datasY),
            //            @"datas2Y" : @(datas2Y),
            //            @"datas3Y" :datas3Y
            //        };
            let chartEntryDic = entry.data
            let datasY = chartEntryDic?["datasY"] as? NSString ?? ""
            let datas2Y = chartEntryDic?["datas2Y"] as? NSString ?? ""
            let datas3Y = chartEntryDic?["datas3Y"] as? NSString ?? ""
            let timestr = chartEntryDic?["timeStr"] as? NSString ?? ""
//            let resultString: String = "时间:  \(timestr) \n价格:  \(datasY) \n均价:  \(datas2Y)\n涨跌:  \(datas3Y)"
            let resultString: String = "(datasY)"
//            setLabel(resultString as String)
            setLabelLeft(String(datasY))
            setLabelRight(String(datas3Y))
            setLabelBotton(String(timestr))
        }
        //        setLabel(String(entry.y))
    }
    
    open func setLabelLeft(_ label: String)
    {
        labelnsLeft = label as NSString
        
        _drawAttributes.removeAll()
        _drawAttributes[NSFontAttributeName] = self.font
        _drawAttributes[NSParagraphStyleAttributeName] = _paragraphStyle
        _drawAttributes[NSForegroundColorAttributeName] = self.textColor
        
        _labelSizeLeft = labelnsLeft?.size(attributes: _drawAttributes) ?? CGSize.zero
        
        var size = CGSize()
        size.width = _labelSizeLeft.width + self.insets.left + self.insets.right
        size.height = _labelSizeLeft.height + self.insets.top + self.insets.bottom
        size.width = max(minimumSize.width, size.width)
        size.height = max(minimumSize.height, size.height)
        self.size = size
    }
    open func setLabelRight(_ label: String)
    {
        labelnsRight = label as NSString
        
        _drawAttributes.removeAll()
        _drawAttributes[NSFontAttributeName] = self.font
        _drawAttributes[NSParagraphStyleAttributeName] = _paragraphStyle
        _drawAttributes[NSForegroundColorAttributeName] = self.textColor
        
        _labelSizeRight = labelnsRight?.size(attributes: _drawAttributes) ?? CGSize.zero
        
        var size = CGSize()
        size.width = _labelSizeRight.width + self.insets.left + self.insets.right
        size.height = _labelSizeRight.height + self.insets.top + self.insets.bottom
        size.width = max(minimumSize.width, size.width)
        size.height = max(minimumSize.height, size.height)
        self.size = size
    }
    open func setLabelBotton(_ label: String)
    {
        labelnsBotton = label as NSString
        
        _drawAttributes.removeAll()
        _drawAttributes[NSFontAttributeName] = self.font
        _drawAttributes[NSParagraphStyleAttributeName] = _paragraphStyle
        _drawAttributes[NSForegroundColorAttributeName] = self.textColor
        
        _labelSizeBotton = labelnsBotton?.size(attributes: _drawAttributes) ?? CGSize.zero
        
        var size = CGSize()
        size.width = _labelSizeBotton.width + self.insets.left + self.insets.right
        size.height = _labelSizeBotton.height + self.insets.top + self.insets.bottom
        size.width = max(minimumSize.width, size.width)
        size.height = max(minimumSize.height, size.height)
        self.size = size
    }

}
