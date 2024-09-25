import NavBar from '../../components/NavBar/Index';

@Entry
@Component
struct RentRoomList {
  @StorageProp('topHeight') topHeight: number = 0;

  build() {
    Column() {
      NavBar({ title: '房源推荐' })
    }
    .height('100%')
    .width('100%')
    .padding({ top: this.topHeight })
  }
}