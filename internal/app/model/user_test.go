package model_test

import (
	"testing"

	"github.com/jMurad/http-rest-api/internal/app/model"
	"github.com/stretchr/testify/assert"
)

func TestUser_BeforeCreate(t *testing.T) {
	u := model.TestUser(t)
	err := u.BeforeCreate()
	assert.NoError(t, err)
	assert.NotZero(t, u.EncryptedPassword)
}
