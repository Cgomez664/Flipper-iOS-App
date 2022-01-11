import Foundation

extension Date {
    var dateTime: PBSystem_DateTime {
        .with {
            $0.year = component(.year)
            $0.month = component(.month)
            $0.day = component(.day)

            $0.hour = component(.hour)
            $0.minute = component(.minute)
            $0.second = component(.second)

            $0.weekday = component(.weekday)
        }
    }

    private func component(_ component: Calendar.Component) -> UInt32 {
        .init(Calendar.current.component(component, from: self))
    }

    init(_ source: PBSystem_DateTime) {
        let date = "\(source.year)-\(source.month)-\(source.day)"
        let time = "\(source.hour):\(source.minute):\(source.second)"
        // swiftlint:disable force_unwrapping
        self.init(iso8601String: "\(date)T\(time)Z")!
    }

    private init?(iso8601String string: String) {
        let formatter = ISO8601DateFormatter()
        guard let date = formatter.date(from: string) else {
            return nil
        }
        self = date
    }
}
