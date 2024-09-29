import { IRentRoomDetail, IReservationRoomParams } from '../models/RentRoomDetailData';
import { http } from '../utils/http';

// 获取房源详情数据
export const getRoomDetailApi = (id: string): Promise<IRentRoomDetail> => {
  return http.get<IRentRoomDetail>('/house/detail', { id })
}

// 预约租房
export const reservationRoomApi = (data: IReservationRoomParams): Promise<null> => {
  return http.post<null>('/auth/house/reservation', data)
}