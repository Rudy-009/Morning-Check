import SwiftUI

struct SleepQualitySelectionView: View {
    
    @Binding var sleepQuality: SleepQuality?
    let allSleepQualities: [SleepQuality] = [.Refreshed, .Invigorated, .Sluggish, .Groggy, .Unrested]
    
    //One of Emotion selected There's little Circle added behind Emotion.
    //if nil => none of has background circle.
    var body: some View {
        VStack {
            ForEach (allSleepQualities, id: \.self) { e in
                SleepQualityToken(sleepQualityRaw: e, sleepQuality: $sleepQuality)
                    .padding()
            }
        }
    }
}

struct SleepQualityToken: View {
    
    var sleepQualityRaw: SleepQuality
    @Binding var sleepQuality: SleepQuality?
    
    var body: some View {
        Button(action: {
            sleepQuality = sleepQuality != sleepQualityRaw ? sleepQualityRaw : nil
        }, label: {
            ZStack{
                if sleepQuality == sleepQualityRaw {
                    Circle()
                        .foregroundColor(.blue)
                        .frame(width: 30)
                }
                Text("\(sleepQualityRaw.rawValue)")
            }
        })
    }
}

#Preview {
    SleepQualitySelectionView(sleepQuality: .constant(.Groggy))
}
