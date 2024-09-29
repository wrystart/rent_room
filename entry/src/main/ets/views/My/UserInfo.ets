import Avatar from '../../components/Avatar/Index'

import rvp from '../../utils/responsive/Index'
import { router } from '@kit.ArkUI'
import { IUserData } from '../../models/UserData'
import { getUserInfoApi } from '../../api/login'

@Component
export default struct UserInfo {
  @StorageProp('token') token: string = ''
  @StorageProp('user') user: IUserData = {
    id: 0,
    nickname: '',
    avatar: ''
  }
  getUserInfo = async () => {
    const user = await getUserInfoApi()
    AppStorage.setOrCreate('user', user)
  }

  aboutToAppear(): void {
    if (this.user.nickname || !this.token) {
      return
    }
    this.getUserInfo()
  }

  build() {
    Row({ space: rvp(10) }) {
      Avatar({ src: this.user?.avatar, avatarSize: rvp(60) })
      if (this.user) {
        Column({ space: rvp(4) }) {
          Text(this.user.nickname).fontSize(rvp(16)).fontColor($r('app.color.white')).fontWeight(700)
          Text('谷粒点15').fontSize(rvp(12)).fontColor($r('app.color.white'))
        }.alignItems(HorizontalAlign.Start)
      } else {
        Column({ space: rvp(4) }) {
          Text('请登录').fontSize(rvp(16)).fontColor($r('app.color.white')).fontWeight(700)
        }.alignItems(HorizontalAlign.Start)
      }
    }.margin({ top: rvp(11) }).width('100%').onClick(() => {
      if (this.user.nickname) {
        return
      }
      router.pushUrl({
        url: 'pages/Login/LoginPhone'
      })
    })
  }
}