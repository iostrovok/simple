package someone

import (
	"testing"

	. "github.com/iostrovok/check"
)

type testSuite struct{}

var _ = Suite(&testSuite{})

func TestSuite(t *testing.T) { TestingT(t) }

func (s *testSuite) TestSyntax(c *C) {
	c.Assert(1, DeepEquals, 1)
}
