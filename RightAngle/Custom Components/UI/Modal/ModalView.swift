//
//  ModalView.swift
//  RightAngle
//
//  Created by Suraj Sukumar Shetty on 06/04/23.
//

import SwiftUI

enum ModalState: CGFloat {
    
    case closed ,partiallyRevealed, open
    
    func offsetFromTop() -> CGFloat {
        switch self {
        case .closed:
            return UIScreen.main.bounds.height
        case .partiallyRevealed:
            return UIScreen.main.bounds.height * 1/4
        case .open:
            return 0
        }
    }
}

struct Modal {
    var position: ModalState  = .closed
    var dragOffset: CGSize = .zero
    var content: AnyView?
}

class ModalManager: ObservableObject {
    
    @Published var modal: Modal = Modal(position: .closed, content: nil)
    
    func newModal<Content: View>(position: ModalState, @ViewBuilder content: () -> Content ) {
        modal = Modal(position: position, content: AnyView(content()))
    }
    
    func openModal() {
        modal.position = .open
    }
    
    func closeModal() {
        modal.position = .closed
    }
    
}

enum DragState {
    
    case inactive
    case dragging(translation: CGSize)
    
    var translation: CGSize {
        switch self {
        case .inactive:
            return .zero
        case .dragging(let translation):
            return translation
        }
    }
    
    var isDragging: Bool {
        switch self {
        case .inactive:
            return false
        case .dragging:
            return true
        }
    }
}


struct ModalView: View {
    @Binding var modal: Modal
    @GestureState var dragState: DragState = .inactive
    
    var animation: Animation {
        Animation
            .interpolatingSpring(stiffness: 300.0, damping: 30.0, initialVelocity: 10.0)
            .delay(0)
    }
    
    var body: some View {
        let drag = DragGesture(minimumDistance: 30)
            .updating($dragState) { drag, state, transaction in
                if modal.position != .closed {
                    state = .dragging(translation:  drag.translation)
                }
            }
            .onChanged {
                self.modal.dragOffset = $0.translation
            }
            .onEnded(onDragEnded)
        
        return GeometryReader(){ geometry in
            ZStack(alignment: .top) {
                Color.black
                    .opacity(self.modal.position != .closed ? 0.5 : 0)
                    .onTapGesture {
                        self.modal.position = .closed
                    }
                ZStack(alignment: .top) {
                    Color("Default")
                    self.modal.content
                        .frame(height: UIScreen.main.bounds.height - (self.modal.position.offsetFromTop() + geometry.safeAreaInsets.top + self.dragState.translation.height))
                }
                .mask(RoundedRectangle(cornerRadius: 8, style: .continuous))
                .offset(y: max(0, self.modal.position.offsetFromTop() + self.dragState.translation.height + geometry.safeAreaInsets.top))
                .gesture(drag)
                .animation(self.dragState.isDragging ? nil : self.animation, value: self.dragState.isDragging)
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
    
    private func onDragEnded(drag: DragGesture.Value) {
        
        // Setting stops
        let higherStop: ModalState
        let lowerStop: ModalState
        
        // Nearest position for drawer to snap to.
        let nearestPosition: ModalState
        
        // Determining the direction of the drag gesture and its distance from the top
        let dragDirection = drag.predictedEndLocation.y - drag.location.y
        let offsetFromTopOfView = modal.position.offsetFromTop() + drag.translation.height
        
        // Determining whether drawer is above or below `.partiallyRevealed` threshold for snapping behavior.
        if offsetFromTopOfView <= ModalState.partiallyRevealed.offsetFromTop() {
            higherStop = .open
            lowerStop = .partiallyRevealed
        } else {
            higherStop = .partiallyRevealed
            lowerStop = .closed
        }
        
        // Determining whether drawer is closest to top or bottom
        if (offsetFromTopOfView - higherStop.offsetFromTop()) < (lowerStop.offsetFromTop() - offsetFromTopOfView) {
            nearestPosition = higherStop
        } else {
            nearestPosition = lowerStop
        }
        
        // Determining the drawer's position.
        if dragDirection > 0 {
            modal.position = lowerStop
        } else if dragDirection < 0 {
            modal.position = higherStop
        } else {
            modal.position = nearestPosition
        }
        
    }
}

//struct ModalView_Previews: PreviewProvider {
////    static var previews: some View {
////        ModalView(modal: <#Binding<Modal>#>)
////    }
//}
