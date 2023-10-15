//
//  Observable.swift
//  MVVM-Binding
//
//  Created by Burak AKCAN on 19.09.2023.
//

import Foundation

final class Observable<T> {
    
    /**
     Value değerini dinleyenlere bildirir. Bu, değeri değiştiren herhangi bir kod tarafından çağrıldığında çalışır.
     */
    var value: T? {
        didSet {
            DispatchQueue.main.async {
                self.listener?(self.value)
            }
        }
    }
    
    init(_ value: T?) {
        self.value = value
    }
    /**
     Bu özellik, gözlemleyici (listener) işlevini temsil eder. listener işlevi, gözlenen değer değiştiğinde çağrılacak işlemdir. Başlangıçta nil olarak ayarlanır çünkü herhangi bir dinleyici atanmayabilir.
     */
    private var listener: ((T?) -> Void)?
    
    /**
     Bu fonksiyon, bir dinleyiciyi Observable'a bağlamak için kullanılır. Bu işlev, bir işlevi parametre olarak alır ve bu işlevi listener özelliğine atar. Ayrıca, başlangıçta mevcut değeri (eğer varsa) yeni dinleyiciye ileterek, mevcut değeri hemen dinleyene iletmek için kullanılır.
     */
    func bind( _ listener: @escaping ((T?) -> Void)) {
        listener(value)
        self.listener = listener
    }
}

//Örnek bir Observable oluşturun
//  let observableValue = Observable<Int>(42)
//
//Observable'a bir dinleyici ekleyin
//  observableValue.bind { newValue in
//    if let newValue = newValue {
//        print("Yeni değer: \(newValue)")
//    } else {
//        print("Değer nil")
//    }
//}
//
//Değeri güncelleyin (Bu, dinleyiciyi tetikler)
//  observableValue.value = 100
