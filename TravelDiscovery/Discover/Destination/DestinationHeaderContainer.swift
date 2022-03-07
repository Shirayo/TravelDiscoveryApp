//
//  DestinationHeaderContainer.swift
//  TravelDiscovery
//
//  Created by Vasili on 28.02.22.
//

import SwiftUI
import Kingfisher

struct DestinationHeaderContainer: UIViewControllerRepresentable {
    
    let imageUrlStrings: [String]
    let chosenPhotoIndex: Int
    
    func makeUIViewController(context: Context) -> UIViewController {
        let pvc = CustomPageViewController(imageUrlStrings: imageUrlStrings, chosenPhotoIndex: chosenPhotoIndex)
        return pvc
    }
    
    typealias UIViewControllerType = UIViewController
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}

class CustomPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = controllers.firstIndex(of: viewController) else { return nil }
        if index <= 0 { return nil }
        return controllers[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = controllers.firstIndex(of: viewController) else { return nil }
        if index == controllers.count - 1 { return nil }
        return controllers[index + 1]
    }
    
    var controllers: [UIViewController] = []
    var chosenPhotoIndex: Int
    
    init(imageUrlStrings: [String], chosenPhotoIndex: Int) {
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.systemGray
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor.red
        self.chosenPhotoIndex = chosenPhotoIndex
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        controllers = imageUrlStrings.map({ imageName in
            if let url = URL(string: imageName) {
                let vc = UIHostingController(rootView:
                    ZStack {
                    Color.black
                    KFImage(url)
                    .resizable()
                    .scaledToFit()
                })
                                               
                vc.view.clipsToBounds = true
                return vc
            } else {
                let vc = UIHostingController(rootView: Text("bad photo url"))
                return vc
            }
        })
        if chosenPhotoIndex < controllers.count {
            setViewControllers([controllers[chosenPhotoIndex]], direction: .forward, animated: true, completion: nil)
        }
        
        self.dataSource = self
        self.delegate = self
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return controllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        self.chosenPhotoIndex
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

struct DestinationHeaderContainer_Previews: PreviewProvider {
    
    static let imageUrlsStrings = [
        "https://letsbuildthatapp-videos.s3.us-west-2.amazonaws.com/7156c3c6-945e-4284-a796-915afdc158b5",
        "https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/b1642068-5624-41cf-83f1-3f6dff8c1702",
        "https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/6982cc9d-3104-4a54-98d7-45ee5d117531",
        "https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/2240d474-2237-4cd3-9919-562cd1bb439e"
        ]
    
    static var previews: some View {
        DestinationHeaderContainer(imageUrlStrings: imageUrlsStrings, chosenPhotoIndex: 0)
            .frame(height: 300)
    }
}
