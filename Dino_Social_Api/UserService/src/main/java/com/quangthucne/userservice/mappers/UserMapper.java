package com.quangthucne.userservice.mappers;

import com.quangthucne.userservice.entities.User;
import com.quangthucne.userservice.validations.UserValid;
import org.mapstruct.*;

import com.quangthucne.userservice.dtos.UserDTO;


@Mapper(componentModel = "spring")
public interface UserMapper {
    User toEntity(UserValid userValid);

    UserDTO toDTO(User user);

}
