import Foundation

final class AvatarsService {
    
    func getAvatarsData() -> [Avatar] {
        let avatar1 = Avatar(image: Images.avatar1)
        let avatar2 = Avatar(image: Images.avatar2)
        let avatar3 = Avatar(image: Images.avatar3)
        let avatar4 = Avatar(image: Images.avatar4)
        let avatar5 = Avatar(image: Images.avatar5)
        let avatar6 = Avatar(image: Images.avatar6)
        let avatar7 = Avatar(image: Images.avatar7)
        let avatar8 = Avatar(image: Images.avatar8)
        
        return [avatar1, avatar2, avatar3, avatar4, avatar5, avatar6, avatar7, avatar8]

    }
}
