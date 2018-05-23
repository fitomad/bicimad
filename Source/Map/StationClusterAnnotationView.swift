//
//  StationClusterAnnotationView.swift
//  BiciKit
//
//  Created by Adolfo Vera Blasco on 21/5/18.
//  Copyright © 2018 Adolfo Vera Blasco. All rights reserved.
//

import MapKit
import Foundation

public class StationClusterAnnotationView: MKAnnotationView
{
    /// La anotación asociada al *cluster* de *pins*
    override public var annotation: MKAnnotation? 
    {
        didSet
        {
            guard let annotation = self.annotation else { return }
            self.prepareMarkerImage(with: annotation)
        }
    }

    /**
        Nuevo cluster para una anotación y un identifcador dado.
    */
    override public init(annotation: MKAnnotation?, reuseIdentifier: String?)
    {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)

        super.displayPriority = .required
        super.collisionMode = .circle
        
        super.centerOffset = CGPoint(x: 0.0, y: -10.0)
    }

    /**
        No lo implemento...  #ParaQué #Pereza
    */
    required public init?(coder aDecoder: NSCoder) 
    {
        fatalError("\(#function) no está implementado")
    }

    /**
        Crea la imagen asociada a este cluster que 
        se mostrará sobre el mapa.

        En este caso uso un fondo naranja con texto en blanco.
        El texto es el número de *pins* que agrupa este cluster.

        - Parameter annotation: Información con la que construir el pin
    */
    private func prepareMarkerImage(with annotation: MKAnnotation) -> Void
    {
        guard let annotation = annotation as? MKClusterAnnotation else 
        { 
            return 
        }

        let items_count = annotation.memberAnnotations.count
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 40.0, height: 40.0))
        
        
        image = renderer.image { _ in
            UIColor.orange.setFill()
            
            UIBezierPath(ovalIn: CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)).fill()
            
            let attributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 20.0)]
            let text = "\(items_count)"
            
            let size = text.size(withAttributes: attributes)
            let rect = CGRect(x: 20 - size.width / 2, y: 20 - size.height / 2, width: size.width, height: size.height)
            
            text.draw(in: rect, withAttributes: attributes)
        }
    }
}
